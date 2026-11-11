Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2585.1794370872133542156
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:12 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3mF2428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:09 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 29/34] configure: Require GCC 5 or later
Date: Tue, 10 Nov 2026 22:20:57 -0600
Message-Id: <1794370862-30908-30-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5294
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

pseudo uses __has_include, which GCC only supports from version 5, so
older compilers such as GCC 4.8 on CentOS 7 failed part way through the
build.

clang reports itself as GCC 4.2.1, so it is only checked for
__has_include.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 README    |  3 +++
 configure | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/README b/README
index 7808463..cbefa56 100644
--- a/README
+++ b/README
@@ -14,6 +14,9 @@ things necessary for creating distribution packages or filesystems.
 pseudo is not a security boundary and must not be used in security
 sensitive applications.  See README.security for details.
 
+Building pseudo requires GCC 5 or later (or clang), which the configure
+script checks for.
+
 To configure, run the provided configure script.  Note that this is
 NOT an autoconf script.
 
diff --git a/configure b/configure
index e659370..01ecd85 100755
--- a/configure
+++ b/configure
@@ -236,6 +236,31 @@ if [ -z "$opt_sqlite_lib" ]; then
     opt_sqlite_lib=$opt_lib
 fi
 
+# pseudo uses __has_include, which needs GCC 5 or later.  clang reports
+# itself as GCC 4.2.1, so only check its support for __has_include.
+if ! cc_version=$(${CC:-cc} -dumpversion 2>/dev/null); then
+    echo >&2 "Error: can't run the C compiler '${CC:-cc}'."
+    exit 1
+fi
+cc_check=$(mktemp -d "${TMPDIR:-/tmp}/pseudo-configure.XXXXXX") || exit 1
+cat > "$cc_check/cc_check.c" <<EOF
+#if defined(__clang__)
+# if !defined(__has_include)
+#  error clang without __has_include
+# endif
+#elif !defined(__GNUC__) || __GNUC__ < 5
+# error GCC older than 5
+#endif
+int pseudo_cc_check;
+EOF
+if ! cc_check_out=$(${CC:-cc} -c -o "$cc_check/cc_check.o" "$cc_check/cc_check.c" 2>&1); then
+    echo >&2 "Error: pseudo requires GCC 5 or later (${CC:-cc} reports version $cc_version)."
+    echo >&2 "$cc_check_out"
+    rm -rf "$cc_check"
+    exit 1
+fi
+rm -rf "$cc_check"
+
 if [ ! -f "${opt_sqlite}/include/sqlite3.h" ]; then
     echo >&2 "SQLite3 headers not found in at ${opt_sqlite}/include/sqlite3.h. Please check that SQLite3 and SQLite3 headers are installed."
     exit 1
-- 
1.8.3.1

