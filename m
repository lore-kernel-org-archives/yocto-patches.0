Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9F8D47CAD
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 23:43:50 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.842.1768520622486113618
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 15:43:42 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 60FNhbjg2408772;
	Thu, 15 Jan 2026 17:43:41 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 11/20] pseudo_util.c: Skip realpath like expansion for /proc on Linux
Date: Thu, 15 Jan 2026 17:43:27 -0600
Message-Id: <1768520616-7289-12-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 23:43:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2986

From: Mark Hatle <mark.hatle@amd.com>

See: Yocto Project bugzilla 16028

Gauthier HADERER (see comment 23) reported an issue where realpath like
behavior of pseudo_fix_path function resulted in a failure of the rust
based tail command.

It was determined that the behavior could be emulated by doing:

echo "test" | tail /dev/fd/0

(tail, cat or any other similar command would result in the same failure)

This results in:
  /dev/fd/0 -> /proc/self/fd/0
  /proc/self/fd/0 -> /proc/1475524/fd/0
  /proc/1475524/fd/0 -> /proc/1475524/fd/pipe:[1177004485]

with an eventual failure of unable to open /proc/1475524/fd/pipe:[1177004485]

This change resolves the issue by detecting the path has been resolved into
the /proc filesystem and then check link targets until it finds one that
does not resolve.  It stops at that points.  This ensures that special /proc
behavior can be maintained.

In the /proc filesystem, on Linux, paths can be opened even if they can't
be stated.  The 'pipe' appears to be one of these special files, so using
lstat to check if it can be opened is an easy way to determine if we have
stumbled onto one of these special files.

Reported-by: Gauthier HADERER <ghaderer@wyplay.com>

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 pseudo_util.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/pseudo_util.c b/pseudo_util.c
index a94a4da..d16b14c 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -614,12 +614,40 @@ pseudo_append_element(char *newpath, char *root, size_t allocated, char **pcurre
 	size_t curlen;
 	int is_dir = S_ISDIR(buf->st_mode);
 	char *current;
+#ifdef PSEUDO_PORT_LINUX
+	int is_proc = 0;
+	char *proc_path = NULL;
+#endif
 	if (!newpath ||
 	    !pcurrent || !*pcurrent ||
 	    !root || !element) {
 		pseudo_diag("pseudo_append_element: invalid args.\n");
 		return -1;
 	}
+
+#ifdef PSEUDO_PORT_LINUX
+	/* If we end up resolving a path into /proc, it has special meaning.
+	 * For instance, /dev/fd/0 -> /proc/self/fd/0 ->
+	 *    /proc/1475524/fd/0 -> /proc/1475524/fd/pipe:[1177004485]
+	 * Trying to access the resolved name "pipe:[....]" may fail.
+	 *
+	 * We verify each link target and only expand if it exists.
+	 */
+	if (strncmp(newpath, "/proc/", 6) == 0) {
+		pseudo_debug(PDBGF_PATH | PDBGF_VERBOSE, "paes: %s in /proc\n",
+			newpath ? newpath : "<nil>");
+		/* Store off the path for later */
+		proc_path = strdup(newpath);
+		/* If memory can't be allocated for newpath,
+		 * fall through and do standard processing
+		 */
+		if (!proc_path)
+			pseudo_diag("allocation failed seeking memory for path (%s).\n", newpath);
+		else
+			is_proc = 1;
+	}
+#endif
+
 	current = *pcurrent;
 	pseudo_debug(PDBGF_PATH | PDBGF_VERBOSE, "pae: '%s', + '%.*s', is_dir %d\n",
 		newpath, (int) elen, element, is_dir);
@@ -700,6 +728,33 @@ pseudo_append_element(char *newpath, char *root, size_t allocated, char **pcurre
 			if (*linkbuf == '/') {
 				current = root;
 			} else {
+#ifdef PSEUDO_PORT_LINUX
+				if (is_proc) {
+					/* Check that the link target exists, otherwise stop resolving since /proc is special! */
+					PSEUDO_STATBUF statbuf;
+
+					size_t target_link_max = pseudo_path_max();
+					char *target_link_path = malloc(pseudo_path_max());
+
+					if (!target_link_path)
+						pseudo_diag("allocation failed seeking memory for path (%s/%s).\n", proc_path, linkbuf);
+						/* Fall through, nothing we can do here */
+					else {
+						snprintf(target_link_path, target_link_max, "%s/%s", proc_path, linkbuf);
+
+						if (!pseudo_real_lstat || (pseudo_real_lstat(target_link_path, &statbuf) == -1)) {
+							pseudo_debug(PDBGF_PATH, "proc link (%s) target (%s) does not exist, skipping.\n", newpath, target_link_path);
+							free(target_link_path);
+							free(proc_path);
+							*pcurrent = current;
+							return 1;
+						} else
+							pseudo_debug(PDBGF_PATH, "proc link (%s) target (%s) exists.\n", newpath, target_link_path);
+
+						free(target_link_path);
+					}
+				}
+#endif
 				/* point back at the end of the previous path... */
 				current -= (elen + 1);
 			}
@@ -716,13 +771,26 @@ pseudo_append_element(char *newpath, char *root, size_t allocated, char **pcurre
 			++link_recursion;
 			retval = pseudo_append_elements(newpath, root, allocated, pcurrent, linkbuf, linklen, 0, buf);
 			--link_recursion;
+
+#ifdef PSEUDO_PORT_LINUX
+			if (is_proc)
+				free(proc_path);
+#endif
+
 			return retval;
 		}
 	}
+
 	/* we used to always append a slash here. now we don't; append_elements
 	 * handles slashes, so just update the pointer.
 	 */
 	*pcurrent = current;
+
+#ifdef PSEUDO_PORT_LINUX
+	/* We must not have used this to get here... */
+	if (is_proc)
+		free(proc_path);
+#endif
 	return 1;
 }
 
-- 
2.43.0


