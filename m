Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2581.1794370870134832812
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:10 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3mI2428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:09 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 32/34] pseudo_util: Skip unneeded lstat calls when canonicalizing paths
Date: Tue, 10 Nov 2026 22:21:00 -0600
Message-Id: <1794370862-30908-33-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5285
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

Path canonicalization called lstat on the base directory and on every
element, including a final element that is not followed, whose result
is never used.  On a tar/chown/find/ls/rm workload of 40,000 files
this was 1.43M lstat calls.

Skip the lstat of a final element that is left alone, and only stat
the base when the first element is "", "." or "..", which are the only
cases where it matters whether the base is a directory.  For any other
name, lstat of the element fails with ENOTDIR under a non-directory,
giving the same result.  This drops the workload to 0.61M lstat calls.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 pseudo_util.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/pseudo_util.c b/pseudo_util.c
index 1e29ba5..d9312d0 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -726,9 +726,13 @@ pseudo_append_element(char *newpath, char *root, size_t allocated, char **pcurre
 	/* if we are not on the last element of a path and supposed to leave
 	 * it alone (for SYMLINK_NOFOLLOW type cases), and we are not trying to
 	 * go further under a regular file, we want to know whether this is a symlink.
-	 * either way, we want to update buf to show the correct state of the file.
+	 * otherwise, update buf to show the correct state of the file.  An
+	 * element we leave alone is always the last one, so nothing uses
+	 * its state and we skip the lstat.
 	 */
-	if (!pseudo_real_lstat || (pseudo_real_lstat(newpath, buf) == -1)) {
+	if (leave_this) {
+		buf->st_mode = 0;
+	} else if (!pseudo_real_lstat || (pseudo_real_lstat(newpath, buf) == -1)) {
 		// if we can't stat it, zero mode so we don't think it's
 		// known to be a link or a regular file.
 		buf->st_mode = 0;
@@ -846,6 +850,7 @@ pseudo_append_elements(char *newpath, char *root, size_t allocated, char **curre
 	/* a shareable buffer so we can cache stat results while walking the path */
 	PSEUDO_STATBUF buf;
 	buf.st_mode = 0;
+	int stat_base = 0;
 	const char * start = path;
 	if (!newpath || !root ||
 	    !current || !*current ||
@@ -861,16 +866,18 @@ pseudo_append_elements(char *newpath, char *root, size_t allocated, char **curre
 		 * then get shared by anything we call.
 		 */
 		sbuf = &buf;
-		if (*current > root) {
-			if (!pseudo_real_lstat || (pseudo_real_lstat(newpath, sbuf) == -1)) {
-				sbuf->st_mode = 0;
-			}
-		} else {
-			/* Don't call lstat on an empty path, or at all when we
-			 * know that "root" is always directory-like.
-			 */
-			sbuf->st_mode = S_IFDIR;
-		}
+		/* Don't call lstat on an empty path, or at all when we
+		 * know that "root" is always directory-like.
+		 */
+		sbuf->st_mode = S_IFDIR;
+		/* The base is only stat'd if the first element is "", "."
+		 * or "..", the only cases where it matters whether the base
+		 * is really a directory.  For any other name, lstat of the
+		 * appended element fails with ENOTDIR under a non-directory,
+		 * giving the same result as stat'ing the base.
+		 */
+		if (*current > root)
+			stat_base = 1;
 	}
 	pseudo_debug(PDBGF_PATH | PDBGF_VERBOSE, "paes: newpath %s, element list <%.*s>\n",
 		newpath, (int) elen, path);
@@ -889,6 +896,15 @@ pseudo_append_elements(char *newpath, char *root, size_t allocated, char **curre
 		 */
 		pseudo_debug(PDBGF_PATH | PDBGF_VERBOSE, "element to add: '%.*s'\n",
 			(int) this_elen, path);
+		if (stat_base) {
+			stat_base = 0;
+			if (this_elen == 0 || (path[0] == '.' &&
+			    (this_elen == 1 || (this_elen == 2 && path[1] == '.')))) {
+				if (!pseudo_real_lstat || (pseudo_real_lstat(newpath, sbuf) == -1)) {
+					sbuf->st_mode = 0;
+				}
+			}
+		}
 		if (pseudo_append_element(newpath, root, allocated, current, path, this_elen, sbuf, leave_this) == -1) {
 			retval = -1;
 			break;
-- 
1.8.3.1

