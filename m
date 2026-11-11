Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2490.1794370872123759461
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:12 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3mG2428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:09 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 30/34] doc: Update README and doc/ to match the code
Date: Tue, 10 Nov 2026 22:20:58 -0600
Message-Id: <1794370862-30908-31-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5286
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

Several descriptions had drifted from the implementation: the README
configure option list had duplicates and was missing options, and the
database, IPC, overview, passwd, chroot, utils and program flow notes
described old schemas, message fields, shutdown timing and wrapper
behavior.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 README           | 38 ++++++++++++++++++++--------
 README.security  |  2 +-
 doc/chroot       | 10 +++++---
 doc/database     | 75 ++++++++++++++++++++++++++++++++++++++------------------
 doc/overview     | 21 ++++++++--------
 doc/passwd       |  7 ++++--
 doc/program_flow |  8 +++++-
 doc/pseudo_ipc   | 37 +++++++++++++++++++---------
 doc/utils        |  6 ++++-
 9 files changed, 139 insertions(+), 65 deletions(-)

diff --git a/README b/README
index cbefa56..caf09b9 100644
--- a/README
+++ b/README
@@ -22,25 +22,43 @@ NOT an autoconf script.
 
 Configure options:
 	    --prefix=/path/to/install/dir
-	    --with-sqlite=/path/to/sqlite/dir
-	    --bits={32,64}
-	    --suffix=<text>
-	    --enable-static-sqlite
-	    --with-sqlite-lib
 	    --libdir=...
+	    --suffix=<text>
+	    --target=<cpu>
 	    --enable-memory-db
+	    --enable-xattr
+	    --enable-xattrdb
+	    --enable-profiling
 	    --enable-force-async
+	    --with-sqlite=/path/to/sqlite/dir
 	    --with-sqlite-lib=...
 	    --enable-static-sqlite
 	    --with-static-sqlite=...
 	    --with-rpath=...|--without-rpath
+	    --with-passwd-fallback=...|--without-passwd-fallback
 	    --cflags=''
+	    --bits={32,64}
+
+The --enable-* options also accept =yes and =no, and --disable-* is the
+same as --enable-*=no.
+
+There is no default prefix.  The default for sqlite is /usr.  If --bits
+is not given, it is guessed from /bin/sh, falling back to 32.  SQLite 3.6
+or later is required.
+
+The --target option sets the CPU the wrappers are generated for (used to
+pick the right syscall numbers); it defaults to the build machine.
+
+Extended attribute support (--enable-xattr) is enabled by default if
+getfattr works on the build machine.  --enable-xattrdb stores extended
+attributes in the database rather than on the files, and implies
+--enable-xattr.  --enable-profiling builds the pseudo_profile utility and
+the client profiling support.
 
-There is no default prefix.  The default for sqlite is /usr, and for
-bits is 32.  You need a reasonably modern sqlite3 -- it has to have
-sqlite3_clear_bindings(), which at least one default sqlite3 install
-did not.  (But that was dated 2006, so I'm not sure this will affect
-most readers.)
+--with-passwd-fallback sets the directory whose etc/passwd and etc/group
+are used when no chroot or PSEUDO_PASSWD file is found; it defaults to /
+(that is, the host's /etc).  --without-passwd-fallback disables the
+fallback.
 
 The suffix value can be used to append a particular text string to file
 names (such as libpseudo<suffix>.so).  This was used in the WR environment
diff --git a/README.security b/README.security
index 8817450..45533f2 100644
--- a/README.security
+++ b/README.security
@@ -91,7 +91,7 @@ that protection in several ways:
 
 * Several wrappers check a path and then act on it by path in a second
   step.  For example, fchmodat (ports/unix/guts/fchmodat.c) stats the
-  path and later calls the real chmod on the same path, and mknodat
+  path and later calls the real fchmodat() on the same path, and mknodat
   (ports/linux/guts/__xmknodat.c) removes the path again by name if the
   database update fails.
 
diff --git a/doc/chroot b/doc/chroot
index a0d1758..75b1d54 100644
--- a/doc/chroot
+++ b/doc/chroot
@@ -12,15 +12,17 @@ are invoked with absolute, canonical, paths.
 A few calls are then modified.  For instance, when readlink() returns
 a link, it strips a leading prefix looking like the chroot directory;
 when symlink() creates a link, if the link path is absolute, the chroot
-directory is prepended to it.
+directory is prepended to it.  (Setting PSEUDO_NOSYMLINKEXP to a value
+other than 0 disables this symlink() behavior.)
 
 This behavior, which may seem surprising, is an attempt to produce
 path resolution equivalent to what would normally happen when
 canonicalizing a path using real chroot; if you create a link to /tmp
 while in a chroot environment, following that link should yield
-<chroot>/tmp.  Arguably, now that we are intercepting nearly every
-incoming path, we should just prepend the chroot path when following
-absolute symlinks -- this may get revisited.
+<chroot>/tmp.  Pseudo's own path canonicalization also resolves absolute
+symlink targets relative to the chroot directory (stripping the chroot
+prefix first if the target already has it), so links created without the
+prefix are still followed correctly inside the chroot.
 
 Similarly, when glob() is called, the path to be globbed has the
 chroot directory prepended, and then the results have any leading
diff --git a/doc/database b/doc/database
index 7003aff..924efd3 100644
--- a/doc/database
+++ b/doc/database
@@ -16,13 +16,13 @@ FILES:
 	rdev (integer)
 	deleting (integer)
 
-There are two indexes on the file database, one by path and one by device
-and inode.  Earlier versions of pseudo ignored symlinks, but this turned
-out to create problems; specifically, if you had a symlink to a directory,
-and accessed a file through that, it could create unexpected results.  Names
-are fully canonicalized by the client, except for functions which would
-operate directly on a symlink, in which case the last path component is not
-replaced.
+There are two indexes on the files table, one on path, device and inode,
+and one on device and inode.  Earlier versions of pseudo ignored symlinks,
+but this turned out to create problems; specifically, if you had a symlink
+to a directory, and accessed a file through that, it could create
+unexpected results.  Names are fully canonicalized by the client, except
+for functions which would operate directly on a symlink, in which case the
+last path component is not replaced.
 
 It is not an error to have multiple entries with the same device and inode.
 Updates to uid, gid, mode, or rdev are applied to every file with the same
@@ -31,21 +31,43 @@ to obtain the device and inode, then modifying all matching records.
 
 If a file shows up with no name (this should VERY rarely happen), it is stored
 in the database with the special name 'NAMELESS FILE'.  This name can never
-be sent by the client (all names are sent as absolute paths).  If a laterThe
+be sent by the client (all names are sent as absolute paths).  If a later
 request comes in with a valid name, the 'NAMELESS FILE' is renamed to it so
 it can be unlinked later.
 
+XATTRS:
+	id (unique key)
+	dev (integer)
+	ino (integer)
+	name (varchar)
+	value (varchar)
+
+The xattrs table holds extended attributes, keyed by device and inode
+(indexed on dev, ino and on dev, ino, name), so they are shared by every
+name for the same file.
+
+MIGRATIONS:
+	id (unique key)
+	version (integer)
+	stamp (integer, seconds since epoch)
+	sql (varchar)
+
+Both databases have a migrations table recording which schema updates
+have been applied, so an older database can be brought up to date when
+it is opened.
+
 The "deleting" field is used to track files which are in the midst of
 being possibly-deleted.  The issue is that if you issue an unlink database
 operation only after removing a file, there is a window during which
 another program can genuinely create a new file with the same name or
 inode, and that request can reach the daemon before the unlink operation
-does.  To address this, three operations are addded:  may-unlink, did-unlink,
+does.  To address this, three operations are added:  may-unlink, did-unlink,
 and cancel-unlink.  The may-unlink operation tags a file for possible
-deletion, setting "deleting" to 1.  A clash involving a file marked for
-deletion is resolved by deleting the existing database entry without
-complaint.  A did-unlink operation deletes a file ONLY if it is marked
-for deletion.  A cancel-unlink operation unmarks a file for deletion.
+deletion, setting "deleting" to the requesting client's ID.  A clash
+involving a file marked for deletion is resolved by deleting the existing
+database entry without complaint.  A did-unlink operation deletes a file
+ONLY if it is marked for deletion by the same client.  A cancel-unlink
+operation unmarks a file for deletion.
 
 You can still have a race condition here, but it seems a lot less likely.
 The failure would be:
@@ -67,12 +89,13 @@ Rename operations use a pair of paths, separated by a null byte; the client
 sends the total length of both names (plus the null byte), and the server
 knows to split them around the null byte.  The impact of a rename on things
 contained within a directory is handled in SQL:
-	UPDATE files SET path = replace(path, oldpath, newpath) WHERE
-		path = oldpath;
-	UPDATE files SET path = replace(path, oldpath, newpath) WHERE
-		(path > oldpath || '/') && (path < oldpath || '0);
+	UPDATE files SET path = ?, deleting = 0 WHERE path = ?;
+	UPDATE files SET path = replace(path, ?, ?), deleting = 0
+		WHERE (path > (? || '/') AND path < (? || '0'));
+with oldpath and newpath bound to the parameters.
 That is to say, anything which either starts with "oldpath/" or is exactly
-equal to oldpath gets renamed, with oldpath replaced by newpath... The
+equal to oldpath gets renamed, with oldpath replaced by newpath, and any
+pending deletion mark is cleared... The
 unusual constructions are to address two key issues.  One is that an "OR"
 would prevent proper use of the index.  The other is that a pattern,
 such as "LIKE oldpath || '/%'", would prevent use of the index (at least
@@ -83,8 +106,9 @@ after it.
 LOGS
 	id (unique key)
 	stamp (integer, seconds since epoch)
-	operation (id from operations, can be null)
+	op (operation id, can be null)
 	client (integer identifier)
+	fd (integer)
 	dev (integer)
 	ino (integer)
 	mode (integer)
@@ -93,17 +117,20 @@ LOGS
 	severity (severity id)
 	text (anything else you wanted to say)
 	tag (identifier for operations)
+	uid (integer)
+	gid (integer)
 	access (integer)
+	program (varchar, name of the client program)
+	type (integer, message type)
 
 The log database contains a primary table (logs).  As of this writing it
 is not indexed, because indexing is expensive during writes (common, for
 the log database) and very few queries are usually run.
 
-The log database also contains, when created, tables of operations, result
-types, and severities.  These exist so that queries can be run against
-a log database even if these values might have changed in a newer build
-of pseudo.  The tables of operations and severities are just id->name pairs.
-No enforcement of the relation is currently provided.
+The op, result, severity and type fields hold the numeric values of
+pseudo's internal enumerations; pseudolog translates them back to names.
+No tables of these names are stored in the database, so a log database
+should be read with a matching build of pseudolog.
 
 The log database "tag" field, added since the initial release of pseudo,
 is available for tagging operations.  When a client connects to the
diff --git a/doc/overview b/doc/overview
index 37d223a..96c883d 100644
--- a/doc/overview
+++ b/doc/overview
@@ -50,16 +50,17 @@ server sends back failure or success notices.
 
 As a fairly typical example, the progress of a stat(2) call is:
 
-* The __xstat() wrapper is called.  This wrapper checks the version argument
-  against the _STAT_VER constant in case we some day run into a system where
-  programs call stat with different versions of struct stat.  (Hasn't happened
-  yet.)
-* The __xstat() wrapper calls the __fxstatat() wrapper, which in turn calls
+* The stat() wrapper (or __xstat(), for programs built against older glibc)
+  is called.
+* That wrapper calls the __fxstatat() wrapper, which in turn calls
   the __fxstatat64() wrapper (this allows us to have only one copy of the
   logic shared among all the path-based stat syscalls).
 * The __fxstatat64() wrapper calls the underlying __fxstatat64() function,
   which has been mapped to the name real___fxstatat64().  (If this fails,
-  the wrapper function returns immediately.)
+  the wrapper function returns immediately.)  It then checks the version
+  argument against the _STAT_VER constant, in case we some day run into a
+  system where programs call stat with different versions of struct stat,
+  and returns the real result unmodified if it doesn't match.
 * The __fxstatat64() wrapper passes the resulting stat buffer and path to the
   client code and asks for a response.
 * The client code converts the stat buffer into a pseudo_msg_t message
@@ -87,8 +88,6 @@ as mkstemp, fopen, and freopen.  These are wrapped because, in glibc, they
 call internal functions which make inline assembly syscalls, rather than
 calling the syscall entry points.  In each case, the wrapper makes the real
 call without intervention, then snoops the results for a file descriptor to
-path mapping.  (This would be done to opendir/fdopendir/closedir as well,
-but the DIR * is opaque and can't be snooped practically.  This is why
-some versions of 'rm -r' can, at higher diagnostic levels, generate a slew
-of warnings about file descriptors being reopened when no close was
-observed.)
+path mapping.  opendir() and closedir() are handled the same way, using
+dirfd() to find the descriptor behind the opaque DIR *.  fdopendir() is not
+wrapped; it uses a descriptor pseudo already knows about.
diff --git a/doc/passwd b/doc/passwd
index 42d41c6..18a05d4 100644
--- a/doc/passwd
+++ b/doc/passwd
@@ -5,8 +5,11 @@ possibly pick a password file other than /etc/passwd, and likewise
 for setgrent() and /etc/group.  The logic is as follows:
 
 * If a chroot directory is set, <chroot>/etc is tried first.
-* If PSEUDO_PASSWD is set, PSEUDO_PASSWD/etc is tried next.
-* Otherwise, fall back on /etc.
+* If PSEUDO_PASSWD is set, PSEUDO_PASSWD/etc is tried next.  PSEUDO_PASSWD
+  may be a colon-separated list of directories, which are tried in order.
+* Otherwise, fall back on the directory set at build time with
+  configure's --with-passwd-fallback (default /, so /etc is used).  If
+  pseudo was built with --without-passwd-fallback, there is no fallback.
 
 In each case, failure to find a passwd or group file results in
 going on to trying the next case.
diff --git a/doc/program_flow b/doc/program_flow
index f7eb26c..4137cf0 100644
--- a/doc/program_flow
+++ b/doc/program_flow
@@ -65,7 +65,13 @@ libpseudo execution flow:
 		pseudo_sigblock
 		pseudo_getlock
 		if antimagic  rc = real_*()
-		else rc = wrap_*()
+		else
+			fix paths (canonicalize path arguments)
+			if path is ignored  rc = real_*()
+			else
+				take path lock (if path_lock is set)
+				rc = wrap_*()
+				drop path lock
 		variadic end (if necessary)
 		pseudo_droplock
 		unmask signals
diff --git a/doc/pseudo_ipc b/doc/pseudo_ipc
index 0892bb7..0d9d6cd 100644
--- a/doc/pseudo_ipc
+++ b/doc/pseudo_ipc
@@ -2,10 +2,11 @@ MESSAGE PASSING
 
 typedef struct {
 	pseudo_msg_type_t type;
-	op_id_t	op;
-	res_id_t result;
+	pseudo_op_t op;
+	pseudo_res_t result;
 	int access;
 	int client;
+	int fd;
 	dev_t dev;
 	unsigned long long ino;
 	uid_t uid;
@@ -14,6 +15,7 @@ typedef struct {
 	dev_t rdev;
 	unsigned int pathlen;
 	int nlink;
+	int deleting;
 	char path[];
 } pseudo_msg_t;
 
@@ -22,12 +24,14 @@ server.  The last field is optional (it's a C99ism called a flexible array
 member, allowing a single allocation to hold both the structure and the
 variable-length character data at the end).
 
-All messages contain items up through 'pathlen'.  If pathlen is not zero,
-an additional pathlen bytes containing path are provided; path is
-null-terminated.
+All messages contain every field up to, but not including, path.  If
+pathlen is not zero, an additional pathlen bytes containing path are
+provided; path is null-terminated.
 
 Every message from client should get a response from server.  The server
-never really sends a path, currently, but maybe it will someday.  Note that
+usually sends no path back; the exceptions are replies to xattr requests
+(attribute values or name lists) and the list of client PIDs in a refused
+SHUTDOWN request, described below.  Note that
 all server responses will in general share a single message object,
 and future operations may cause that object to be reallocated; the same
 goes for messages received by the server.  Basically, pseudo_msg_receive
@@ -36,16 +40,19 @@ mutex stuff in the wrappers.  (The other part is the "antimagic" being
 able to blow things up.)
 
 type is one of PING, OP, FASTOP, SHUTDOWN, ACK, or NAK.  The client
-only sends PING, OP, or FASTOP.  FASTOP takes no response, otherwise the
-server should always send ACK.  When run with '-S', the pseudo program
+only sends PING, OP, or FASTOP.  FASTOP is used for operations whose result
+the client doesn't need, but the server still replies with ACK (or NAK on
+failure) and the client still waits for that reply.
+
+When run with '-S', the pseudo program
 runs as a client, sending a SHUTDOWN message to a server -- but only if
 it can find one, it does not start a new one.  In this case, the server
 could respond with a NAK, in which case it sends a message in which
 "path" is a list of space-separated PIDs of currently-living clients,
 for the program to print out in an error message.  The server will
 not shut down while there are living clients.  (The request, though,
-causes it to shut down immediately when there are no more clients,
-rather than waiting for the timeout period.)
+reduces the timeout to 3 seconds, so it shuts down shortly after the
+last client goes away rather than waiting for the full timeout period.)
 
 result is the result of a particular operation.  It applies only in replies
 to OP messages.
@@ -54,9 +61,13 @@ client should be the client's PID on send, and the server's client number for
 that client on response.  (The response isn't checked, and this is just a
 debugging feature.)
 
+fd is the file descriptor involved in the operation, if any.  It is
+recorded in the log database.  In a NAK reply to SHUTDOWN, it holds the
+number of other live clients.
+
 dev/ino/uid/gid/mode/rdev/path are information about the file.  They should
 all be provided on send if possible, but the server only generally changes
-uid/gid/mode/rdev on response, and never sends a path back.  Dev and inode
+uid/gid/mode/rdev on response.  Dev and inode
 are currently changed by stat-by-path operations, but this may turn out to
 be wrong.
 
@@ -69,6 +80,10 @@ nlink is used to forward the number of links.  The server DOES NOT modify
 this.  Rather, nlink is used to provide better diagnostics when checking
 paths against inodes.
 
+deleting carries the database's "deleting" mark (see doc/database) when
+the server looks up file entries.  The server uses it internally; the
+client doesn't set or use it.
+
 32/64 bit:  This structure should have the same offsets for every element,
 including path, on both 64-bit and 32-bit machines.  (Check with 'offsets.c'.)
 It is *not* an error if sizeof(pseudo_msg_t) is different; the padding
diff --git a/doc/utils b/doc/utils
index 35520d4..7b18af6 100644
--- a/doc/utils
+++ b/doc/utils
@@ -20,7 +20,7 @@ pseudo
 	is 30 seconds, or whatever you specified with "-t" or PSEUDO_OPTS
 	when starting it) or run "pseudo -S".  The server will not exit
 	while clients are active, but requesting a shutdown sets the timeout
-	to one second, so it will exit quickly after the last client
+	to 3 seconds, so it will exit quickly after the last client
 	disconnects.
 
 libpseudo.so
@@ -31,3 +31,7 @@ libpseudo.so
 
 pseudodb
 	allows browsing and modification of db (not implemented)
+
+pseudo_profile
+	Only built with --enable-profiling.  Reads and summarizes the
+	profiling data written by clients when PSEUDO_PROFILE_PATH is set.
-- 
1.8.3.1

