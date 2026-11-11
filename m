Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.560.1794413715276216277
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Nov 2026 08:15:15 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6ABGFDdh2529923
	for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 10:15:14 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][pseudo-1.9]PATCH 02/10] makewrappers: Don't generate unused _int paths with noignore_path
Date: Wed, 11 Nov 2026 10:15:04 -0600
Message-Id: <1794413712-18072-3-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794413712-18072-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794413712-18072-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 16:15:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5298
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

With preserve_paths=1 the canonical path from pseudo_root_path() is
stored in <path>_int rather than overwriting the path argument. The
only reader of <path>_int is the ignore_paths() check, which is not
generated when noignore_path=1 is also set.

open_tree, open_tree_attr and openat2 set both options, so path_int was
assigned but never used, resulting in:

  warning: variable 'path_int' set but not used [-Wunused-but-set-variable]

It also meant an extra pseudo_root_path() call per invocation, as the
guts for these functions resolve the path themselves.

Skip the declaration and assignment of the _int paths when both options
are set. The generated code for all other wrappers is unchanged.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
(cherry picked from commit f86ca21137e8a846ba64e66243a54554be533c5e)
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 makewrappers | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/makewrappers b/makewrappers
index 19508fa..4c99cf3 100755
--- a/makewrappers
+++ b/makewrappers
@@ -389,7 +389,8 @@ class Function:
         return self.args.call()
 
     def paths_decl(self):
-        if self.preserve_paths:
+        # path_int is only read by the ignore_paths() check
+        if self.preserve_paths and not self.noignore_path:
             return "\n\t".join("char *" + path + "_int;" for path in self.paths_to_munge)
         return ""
 
@@ -420,6 +421,9 @@ class Function:
                     "\t\t\t%s -1;\n"
                     "\t\t\tgoto quick_exit;\n"
                     "\t\t}\n" % (path, self.rc_assign()))
+            if self.preserve_paths and self.noignore_path:
+                # path_int is only read by the ignore_paths() check
+                continue
             fix_paths.append(
                 "%s = pseudo_root_path(__func__, __LINE__, %s%s, %s, %s);" %
                 (pathvar, prefix, self.dirfd, path, self.flags))
-- 
1.8.3.1

