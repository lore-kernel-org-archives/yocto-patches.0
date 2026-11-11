Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2578.1794370868480846637
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:08 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3m82428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:07 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 22/34] pseudo_util: Make -v and numeric PSEUDO_DEBUG add debug flags
Date: Tue, 10 Nov 2026 22:20:50 -0600
Message-Id: <1794370862-30908-23-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5279
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

Since 2a7591e, pseudo_debug_set() replaces the debug flags, so each -v,
and each step of a numeric PSEUDO_DEBUG level, replaced the previous
flag instead of adding to it: -v -v -v gave "o" instead of "nfo".  Add
the flag in pseudo_debug_verbose() instead.  Also start a numeric level
from no flags, as pseudo_init_util() can run more than once in a
process and each run added another set.

Add test-debug-flags, covering -v, numeric PSEUDO_DEBUG, and how
PSEUDO_SEVERITY and -k reach programs run under pseudo.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 pseudo_util.c            | 12 ++++++----
 test/test-debug-flags.sh | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 4 deletions(-)
 create mode 100755 test/test-debug-flags.sh

diff --git a/pseudo_util.c b/pseudo_util.c
index 631c3e9..1eb90d5 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -96,6 +96,8 @@ static unsigned long pseudo_severity_flags_in(char *);
  * best to handle that case.
  */
 static int pseudo_util_initted = -1;  /* Not yet run */
+/* number of debug flags turned on by pseudo_debug_verbose() */
+static int max_debug_level = 0;
 
 /* bypass wrapper logic on path computations */
 int (*pseudo_real_lstat)(const char *path, PSEUDO_STATBUF *buf) = NULL;
@@ -217,6 +219,10 @@ pseudo_init_util(void) {
 		int i;
 		int level = pseudo_atoi_wrapper(env);
 		if (level > 0) {
+			/* a level selects the first <level> flags, even if
+			 * this runs more than once in a process */
+			pseudo_util_debug_flags = 0;
+			max_debug_level = 0;
 			for (i = 0; i < level; ++i) {
 				pseudo_debug_verbose();
 			}
@@ -379,9 +385,6 @@ with_libpseudo(char *list) {
 
 char *pseudo_version = PSEUDO_VERSION;
 
-/* going away soon */
-static int max_debug_level = 0;
-
 void
 pseudo_debug_terse(void) {
 	char s[2] = { pseudo_debug_type_symbolic(max_debug_level) };
@@ -397,7 +400,8 @@ pseudo_debug_verbose(void) {
 	char s[2] = { pseudo_debug_type_symbolic(max_debug_level + 1) };
 
 	if (s[0]) {
-		pseudo_debug_set(s);
+		/* add to the flags already set, unlike pseudo_debug_set() */
+		pseudo_util_debug_flags |= pseudo_debug_flags_in(s);
 		++max_debug_level;
 	}
 }
diff --git a/test/test-debug-flags.sh b/test/test-debug-flags.sh
new file mode 100755
index 0000000..1cf6b14
--- /dev/null
+++ b/test/test-debug-flags.sh
@@ -0,0 +1,59 @@
+#!/bin/bash
+#
+# SPDX-License-Identifier: LGPL-2.1-only
+#
+# Check how debugging and severity settings reach programs run under pseudo:
+# - each -v adds the next debugging flag to those already set;
+# - a numeric PSEUDO_DEBUG turns on exactly that many flags, even in a process
+#   which initializes the client library more than once;
+# - PSEUDO_SEVERITY is passed on as severity names, from the default or -k.
+
+tmpdir="$(mktemp -d -p "$PWD" debug_flags_XXXXXX)"
+mkdir "$tmpdir/state"
+
+# Run a separate pseudo, with its own state directory, outside of the pseudo
+# running this test: PSEUDO_UNLOAD keeps libpseudo out of env(1), which then
+# starts pseudo with a clean environment.
+new_pseudo() {
+	PSEUDO_UNLOAD=1 env -u PSEUDO_UNLOAD -u PSEUDO_DEBUG -u PSEUDO_SEVERITY \
+		PSEUDO_LOCALSTATEDIR="$tmpdir/state" ./bin/pseudo "$@"
+}
+trap "new_pseudo -S >/dev/null 2>&1; rm -rf '$tmpdir'" EXIT TERM INT
+
+rc=0
+fail() {
+	echo "FAILED: $*"
+	rc=1
+}
+
+# value of a variable in the environment of a program run by a new pseudo
+var_under() {
+	local var=$1
+	shift
+	new_pseudo "$@" env | sed -n "s/^$var=//p"
+}
+
+check() {
+	local want=$1 got=$2
+	shift 2
+	[ "$got" = "$want" ] || fail "$*: got '$got', expected '$want'"
+}
+
+check nfo "$(var_under PSEUDO_DEBUG -v -v -v)" "pseudo -v -v -v"
+check no "$(var_under PSEUDO_DEBUG -x o -v)" "pseudo -x o -v"
+check info,warn,error "$(var_under PSEUDO_SEVERITY)" "default PSEUDO_SEVERITY"
+check warn,error "$(var_under PSEUDO_SEVERITY -k warn,error)" "pseudo -k warn,error"
+
+# A level turns on the first flags in order: o (operations, which logs
+# "exec" messages) is the third and P (process IDs, "new pid") the fourth.
+# The commands initialize the client library more than once.
+for level in 2 4; do
+	PSEUDO_DEBUG=$level PSEUDO_DEBUG_FILE="$tmpdir/debug.$level" \
+		sh -c '/bin/true; sh -c /bin/true' 2>/dev/null
+done
+grep -q "new pid:" "$tmpdir/debug.2" 2>/dev/null &&
+	fail "PSEUDO_DEBUG=2 turned on more than the first two debugging flags"
+grep -q "exec /" "$tmpdir/debug.4" 2>/dev/null ||
+	fail "PSEUDO_DEBUG=4 didn't turn on the first four debugging flags"
+
+exit $rc
-- 
1.8.3.1

