Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2579.1794370869336440519
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:09 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3mD2428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:08 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 27/34] pseudo.1: Update to match the current code
Date: Tue, 10 Nov 2026 22:20:55 -0600
Message-Id: <1794370862-30908-28-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5282
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

Document the -k, -p and -P options, the full list of debugging flags,
-v and numeric PSEUDO_DEBUG levels, and the PSEUDO_SEVERITY,
PSEUDO_IGNORE_PATHS, PSEUDO_INCLUDE_PATHS, PSEUDO_EVLOG and
PSEUDO_EVLOG_FILE variables.

Rewrite DIAGNOSTICS for the severity flags and the event log, and BUGS
for pseudo's use of fcntl(2) locks, dropping the outdated promise of a
future fix. Add a SECURITY section that pseudo is a build tool, relies
on the cooperation of the programs it runs, and is not secure by design.

Fix PSEUDO_NOSYMLINKEXP, whose meaning was inverted: symlink expansion
is on when the variable is unset or 0, and disabled by any other value.
Note that PSEUDO_PASSWD may also be a colon-separated list of
directories, while -p accepts only a single directory.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 pseudo.1 | 318 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 281 insertions(+), 37 deletions(-)

diff --git a/pseudo.1 b/pseudo.1
index 40429aa..2ccf6bd 100644
--- a/pseudo.1
+++ b/pseudo.1
@@ -26,6 +26,14 @@ pseudo \- run a command in a virtual root environment
 .I flags
 ]
 [
+.B \-k
+.I severities
+]
+[
+.B \-p
+.I path
+]
+[
 .B \-P
 .I prefix
 ]
@@ -249,12 +257,53 @@ runs as a server, and does not try to start other commands.  This mode
 is useful for debugging.
 
 .TP 8
+.BI \-k\  severities
+Select which
+.I pseudo
+diagnostic messages are shown, as a comma-separated list of severities.
+Leaving out
+.B info
+or
+.B warn
+suppresses informational messages or warnings; errors are always shown.
+The default is
+.IR info,warn,error .
+This sets the
+.B PSEUDO_SEVERITY
+environment variable, so it also applies to programs started by this
+invocation of
+.IR pseudo .
+
+.TP 8
 .BI \-l\  (log)
 Enable logging.  The
 .I pseudo
 daemon will log every filesystem transaction in the log database.
 
 .TP 8
+.BI \-p\  path
+Set the
+.B PSEUDO_PASSWD
+environment variable to the absolute path of
+.IR path :
+the directory containing the
+.I etc/passwd
+and
+.I etc/group
+files used to emulate password and group lookups.
+Only a single directory is accepted; to search several, set
+.B PSEUDO_PASSWD
+to a colon-separated list directly.
+
+.TP 8
+.BI \-P\  prefix
+Set the
+.B PSEUDO_PREFIX
+environment variable: the directory under which
+.I pseudo
+finds its server and keeps its database.
+
+.TP 8
 .BI \-r\  root
 .TP 8
 .BI \-R\  root
@@ -282,23 +331,33 @@ new clients can restart the daemon if they need it.
 
 .TP 8
 .BI \-v\  (verbose)
-Increase the verbosity of the
+Enable debugging messages from the
 .I pseudo
 daemon, and the client library for any programs started by this
 invocation of
 .IR pseudo .
-This is equivalent to the numeric form of the
+Each
+.B \-v
+turns on the next debugging flag, in the order listed under
 .B PSEUDO_DEBUG
-environment variable; multiple
+in
+.BR ENVIRONMENT ,
+in addition to those already on, so multiple
 .B \-v
-options increase the debugging level.
+options increase the debugging level.  This is equivalent to the numeric
+form of the
+.B PSEUDO_DEBUG
+environment variable.  Use
+.B \-x
+to choose specific flags.
 
 .TP 8
 .BI \-x\  (debug)
-Set specific debugging flags (the
-.I pseudo
-utility's help message lists them). This is equivalent to the string
-form of the
+Set specific debugging flags, as letters (listed under
+.B PSEUDO_DEBUG
+in
+.BR ENVIRONMENT ).
+This sets the
 .B PSEUDO_DEBUG
 environment variable.
 
@@ -376,8 +435,11 @@ device/inode numbers.
 .SH DIAGNOSTICS
 Depending on invocation, diagnostic messages usually go either to standard
 error or to the file
-.B PSEUDO_PREFIX
-.IR /var/pseudo/pseudo.log .
+.I pseudo.log
+in
+.B PSEUDO_LOCALSTATEDIR
+(by default,
+.BR PSEUDO_PREFIX /var/pseudo).
 By default,
 .I pseudo
 daemon messages go into the log file, but messages generated by the client
@@ -385,21 +447,33 @@ code go to standard error.  These can be changed using the
 .B PSEUDO_DEBUG_FILE
 environment variable, documented in
 .BR ENVIRONMENT .
-At the default logging level, only critical
-messages are displayed.  If you have raised the logging level (using the
-.I \-v
+If a client can't communicate with the server, it aborts, first writing
+its most recent events (see
+.BR PSEUDO_EVLOG )
+to standard error, or to the file named by
+.BR PSEUDO_EVLOG_FILE .
+
+Diagnostic messages are errors, warnings and informational messages.
+Errors are always shown.  Warnings and informational messages are shown
+by default, and can be suppressed with the
+.B \-k
 option or the
+.B PSEUDO_SEVERITY
+environment variable.  Debugging messages are only shown if enabled with
+the
+.BR \-v\  or\  \-x
+options or the
 .B PSEUDO_DEBUG
-environment variable), additional messages are displayed.  Levels higher
-than 2 are very unlikely to be useful outside of
+environment variable, and are very unlikely to be useful outside of
 .I pseudo
 development.
 
-Diagnostic messages seen by default are those which are believed to indicate
-either a serious internal flaw in
+Errors indicate either a serious internal flaw in
 .I pseudo
-or a completely unexpected failure from the underlying operating system.  In
-normal use, you should see no diagnostic messages.
+or an unexpected failure from the underlying operating system.  Warnings
+and informational messages report unusual conditions, such as a program
+calling a function the underlying C library doesn't provide.  In normal
+use, you should see few diagnostic messages.
 
 .SH ENVIRONMENT
 The most significant environment variables for
@@ -434,14 +508,77 @@ path.  Paths that are relative to this are treated as though they were
 instead relative to the filesystem root.
 .TP 8
 .B PSEUDO_DEBUG
-This variable holds either a numeric "debug level" for
-.I pseudo
-to run at, or a set of specific debugging flags, generally letters.
-Use
-.B pseudo -h
-to see the available flags. In general, this is useful only for debugging
-.I pseudo
-itself.
+This variable holds either a set of debugging flags, as letters, or a
+number, which turns on that many flags in the order listed below, as
+with repeated
+.B \-v
+options.  In general, this is useful only for debugging
+.I pseudo
+itself.  The flags are:
+.RS
+.PD 0
+.TP 4
+.B n
+consistency checks
+.TP 4
+.B f
+file creation/deletion
+.TP 4
+.B o
+operations
+.TP 4
+.B P
+show process IDs
+.TP 4
+.B c
+client side startup/shutdown
+.TP 4
+.B v
+server side startup/shutdown
+.TP 4
+.B d
+database interactions
+.TP 4
+.B D
+xattr database
+.TP 4
+.B R
+profiling
+.TP 4
+.B y
+system calls
+.TP 4
+.B e
+environment manipulation
+.TP 4
+.B r
+chroot functionality
+.TP 4
+.B p
+path computations
+.TP 4
+.B s
+SQL query information
+.TP 4
+.B w
+wrapper functionality
+.TP 4
+.B i
+client/server interactions
+.TP 4
+.B k
+invocation and launching
+.TP 4
+.B b
+performance statistics
+.TP 4
+.B V
+extra detail, for the other flags given
+.TP 4
+.B x
+extended attributes
+.PD
+.RE
 .TP 8
 .B PSEUDO_DEBUG_FILE
 The name of a file to use for debugging messages from the pseudo client;
@@ -501,6 +638,53 @@ no function outside of debugging
 .I pseudo
 itself.
 .TP 8
+.B PSEUDO_EVLOG
+This variable holds debugging flags, as for
+.BR PSEUDO_DEBUG ,
+selecting events which the client library records in memory, keeping the
+most recent 250.  Currently only the
+.B c
+flag (client side startup/shutdown) records events: starting the server,
+connecting to it, and retrying requests.  If a client gives up because it
+can't communicate with the server, it writes these events to the
+.B PSEUDO_EVLOG_FILE
+file, or to standard error, before aborting.  This is useful only for
+debugging
+.I pseudo
+itself.
+.TP 8
+.B PSEUDO_EVLOG_FILE
+The name of a file to write the client's event log to, instead of
+standard error (see
+.BR PSEUDO_EVLOG ).
+As with
+.BR PSEUDO_DEBUG_FILE ,
+a single
+.B %s
+is replaced with the short program name, and a single
+.B %d
+with the process ID.
+.TP 8
+.B PSEUDO_IGNORE_PATHS
+A comma-separated list of path prefixes.  Operations on a path which
+starts with one of them are passed directly to the underlying C library,
+and are not recorded in the
+.I pseudo
+database.  The prefixes are compared as strings, so
+.I /tmp
+also matches
+.IR /tmpfiles .
+Paths inside the current emulated
+.I chroot
+directory are never ignored.
+.TP 8
+.B PSEUDO_INCLUDE_PATHS
+A comma-separated list of path prefixes.  If this variable is set,
+only operations on paths which start with one of them are tracked, and
+all other paths are ignored as for
+.BR PSEUDO_IGNORE_PATHS ,
+which is then not used.
+.TP 8
 .B PSEUDO_LIBDIR
 This directory holds the path to the
 .I pseudo
@@ -527,10 +711,10 @@ prepends the chroot directory to
 the paths used for absolute symlinks; this behavior ensures that
 opening symlinks produces expected results in most cases.  In some
 cases you may want to suppress this.  If this variable is unset, or
-set to any value other than 0,
+set to 0,
 .I pseudo
-expands symlink paths like this.  If this variable is set to 0,
-the behavior is disabled.
+expands symlink paths like this.  If this variable is set to any other
+value, including an empty string, the behavior is disabled.
 .TP 8
 .BR PSEUDO_OPTS
 This variable holds options to be passed to any new
@@ -553,6 +737,8 @@ directory containing files named
 .I passwd
 and
 .IR group .
+It may also be a colon-separated list of such directories, which are
+tried in order.
 When
 .I pseudo
 is emulating a
@@ -600,6 +786,18 @@ and recorded in the log database if any logging occurs related to a
 specific client.  Note that different clients may have different tags
 associated with them; the tag value is per-client, not per-server.
 .TP 8
+.B PSEUDO_SEVERITY
+A comma-separated list of severities selecting which diagnostic messages
+are shown, as for the
+.B \-k
+option.  Leaving out
+.B info
+or
+.B warn
+suppresses informational messages or warnings; errors are always shown.
+The default is
+.IR info,warn,error .
+.TP 8
 .BR PSEUDO_UIDS ,\  PSEUDO_GIDS
 These variables are used internally to pass information about the current
 emulated user and group identity from one process to another.
@@ -637,18 +835,17 @@ The
 database is not particularly robust in the face of whole directory trees
 being moved, or changes in the underlying device and inode numbers.  It
 has a reasonable chance of recovering if only the path or the device numbers
-have changed, but it is not particularly designed to address this.  A future
-release is expected to have improved resilience in these cases.
+have changed, but it is not particularly designed to address this.
 
 The filesystem on which
 .I pseudo
 keeps its database and files must at a minimum support UNIX domain sockets
-and reasonable file locking semantics.  Note that
+and
+.I fcntl(2)
+record locks.
 .I pseudo
-relies on
-.I flock(2)
-locking semantics; a lock has to persist into a child process.  This should
-probably eventually be fixed.
+uses these locks for the server's lock file, and to keep clients from
+changing the same path at the same time.
 
 The
 .I pseudo
@@ -662,6 +859,53 @@ than it is otherwise.  This is probably because nearly every operation
 communication with the server, and probably some kind of database
 activity.
 
+.SH SECURITY
+.I pseudo
+is intended for build environments, where ordinary users produce
+packages and filesystem images containing files that appear to be owned
+by root, device nodes, and special permissions and attributes.  It is
+not a security boundary, is not secure by design, and must not be used
+to contain untrusted programs or in security sensitive applications.
+
+.I pseudo
+relies on the cooperation of the programs it runs.  It only sees calls
+that go through
+.IR libpseudo.so ,
+so statically linked programs, setuid programs, programs that make
+system calls directly, and programs that remove it from
+.B LD_PRELOAD
+or set
+.B PSEUDO_UNLOAD
+or
+.B PSEUDO_DISABLED
+all reach the real filesystem with the privileges of the user running
+.IR pseudo .
+Its emulated
+.I chroot(2)
+does not confine anything.
+
+The ownership and permissions that programs see exist only in the
+.I pseudo
+database: the files themselves belong to the user running
+.IR pseudo ,
+who can read and write them whatever their emulated owner and mode.
+The database can fall out of step with the filesystem if the tree is
+changed outside of
+.IR pseudo ,
+and
+.I pseudo
+works with paths in ways that are open to races if other processes
+change the tree at the same time.  Only use
+.I pseudo
+on trees that are private to the build, and check the ownership,
+permissions and attributes of security relevant files in the result.
+
+See
+.I README.security
+in the
+.I pseudo
+source tree for details.
+
 .SH SEE ALSO
 fakeroot(1), ld.so(8), pseudolog(1), sqlite3(1)
 .SH FURTHER READING
-- 
1.8.3.1

