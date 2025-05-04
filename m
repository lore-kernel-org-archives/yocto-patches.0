Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7AEC369DC
	for <webhook@archiver.kernel.org>; Sun,  4 May 2025 16:45:30 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.32239.1746377123625905077
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 04 May 2025 09:45:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Ge47diS1;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39ee57c0b8cso3297187f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 04 May 2025 09:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746377121; x=1746981921; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xdZJHJIeVDgheT11aOur9e7qcITEwBsv9+Tg2fvEf+0=;
        b=Ge47diS1jBinnigb5jV2SUZe2pc+9OBBntBmBMqPxoRGKlsGiISQTutDsBFTrskAn4
         vbUTkYdU/PcGBFTwRRiWGvN5UpMJERCS9aiUZOG98d0PuNRL69xpLQDwfKLOe+tMmogZ
         /pb3x+SrlPRvHC7+n3uagrKmhKAlis0xW+dDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746377121; x=1746981921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xdZJHJIeVDgheT11aOur9e7qcITEwBsv9+Tg2fvEf+0=;
        b=fJahO/iEpeufFJzHe/mhAKzHTjzmbzJ6+f6KeY0r5QoA0HhaKzj+9jR9NsopTTAhxP
         bWmy4Oj7+d9YkCR00ZemKCwLaODLjR54le5bf7/nKFpk8qaAFH2EXExBEjZ6wfGLuHlr
         PXp+mzeXpECi2xqKaCukQAHghth52uAUof66RuNQWp59oFBNw78LZQGbCTES37GrJ12S
         /nV5oTaZNxYMMG0U4U/B+TUhCsIxDyZeOkaTry+8VW7UDvjHBTIBk45Fg+LjnR5bmqOi
         QXnI3hgrZKjdPXOfPt3jYDRAVh5q1H3pqwu0yymtFHNzt907UMqByKru2pS1Euh8THTb
         vFqw==
X-Gm-Message-State: AOJu0YwUvtby4jDBh3u1iyVBo29hK1G3KoQaCuzyKK5vwAeEpIWJRBq+
	gy0piINMkFsEU6L+9BdlG4QTH8ws1rVYG2KKnuZ0x/5Tll7QuXF+6FZpt2LIlhUBKXJTL1y8271
	g
X-Gm-Gg: ASbGnct3GcwWwhS9p8U6vrZigx08DhnyU+JrbWzMle+sZrZafq6HSMFu3Y/Zsqa66Bc
	TAL5hxXFbplWT5HaOpeyApLaV0XSeZdJnJYgIbiBysauMUWUXhI2fR3CFqPRDvV9gfuqD19k8uu
	vMcBzB47QAfBxWz80ryC99lpAJYHEn+8T5lUgkfUvqZUCkjt10drZZ8Cc2JQVF82qyqywkqspC5
	GNL2wg6qjvWUrRikl4e1vFcyU9Y9TCO13lnaZEIwKWdKyWwDNqfSWIIwIBlFlPedv1Fn8pKorHR
	XriJDGbo1tGhPTZK9Xri3X/mUyq835Eh3z35t36YNUoC18htLZVAoZaJ8ngHxu0hlv1HOA==
X-Google-Smtp-Source: AGHT+IE2qMsUxglU5AgwhTs4Y7xh9bYQ+KYKLBKP4SMQgt/Ci9yKMjdvM7HUmEiXqzjTrqfdwoBzEA==
X-Received: by 2002:a05:6000:402b:b0:3a0:99e9:bc90 with SMTP id ffacd0b85a97d-3a09fd6df05mr3782935f8f.10.1746377121068;
        Sun, 04 May 2025 09:45:21 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:994e:224d:4a8f:bee7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b170d0sm7902160f8f.99.2025.05.04.09.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 May 2025 09:45:20 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net,
	mark.hatle@kernel.crashing.org
Subject: [pseudo] [PATCH] pseudo/pseudo_client: Add wrapper functions to operate correctly with glibc 2.38 onwards
Date: Sun,  4 May 2025 17:45:19 +0100
Message-ID: <20250504164519.65912-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 04 May 2025 16:45:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1490

glibc 2.38 would include  __isoc23_strtol and similar symbols. This is trggerd by
_GNU_SOURCE but we have to set that for other definitions. Therefore add seperate
wrapper functions so we can control the contexts correctly and avoid that include
when using the problematic functions (strtol, strtoll, atoi, fscanf and sscanf).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 Makefile.in              | 16 +++++++++-------
 ports/unix/guts/linkat.c |  2 +-
 pseudo.c                 |  2 +-
 pseudo.h                 |  4 ++++
 pseudo_client.c          | 21 +++++----------------
 pseudo_client.h          |  4 ++++
 pseudo_client_scanf.c    | 39 +++++++++++++++++++++++++++++++++++++++
 pseudo_util.c            |  2 +-
 pseudolog.c              |  4 ++--
 strtol.c                 | 26 ++++++++++++++++++++++++++
 10 files changed, 92 insertions(+), 28 deletions(-)
 create mode 100644 pseudo_client_scanf.c
 create mode 100644 strtol.c

diff --git a/Makefile.in b/Makefile.in
index 48fdbd2..7ecb325 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -57,7 +57,7 @@ SOURCES=$(wildcard *.c)
 OBJS=$(subst .c,.o,$(SOURCES))
 TESTS=$(patsubst %.c,%,$(wildcard test/*.c))
 
-SHOBJS=pseudo_tables.o pseudo_util.o
+SHOBJS=pseudo_tables.o pseudo_util.o strtol.o
 DBOBJS=pseudo_db.o
 WRAPOBJS=pseudo_wrappers.o
 
@@ -100,15 +100,15 @@ $(BIN) $(LIB):
 
 pseudo: $(PSEUDO)
 
-$(PSEUDO): pseudo.o $(SHOBJS) $(DBOBJS) pseudo_client.o pseudo_server.o pseudo_ipc.o | $(BIN)
+$(PSEUDO): pseudo.o $(SHOBJS) $(DBOBJS) pseudo_client.o pseudo_client_scanf.o pseudo_server.o pseudo_ipc.o | $(BIN)
 	$(CC) $(CFLAGS) $(CFLAGS_PSEUDO) -o $(PSEUDO) \
-		pseudo.o pseudo_server.o pseudo_client.o pseudo_ipc.o \
+		pseudo.o pseudo_server.o pseudo_client.o pseudo_client_scanf.o pseudo_ipc.o \
 		$(DBOBJS) $(SHOBJS) $(LDFLAGS) $(DB_LDFLAGS) $(CLIENT_LDFLAGS)
 
 pseudolog: $(PSEUDOLOG)
 
-$(PSEUDOLOG): pseudolog.o $(SHOBJS) $(DBOBJS) pseudo_client.o pseudo_ipc.o | $(BIN)
-	$(CC) $(CFLAGS) $(CFLAGS_PSEUDO) -o $(PSEUDOLOG) pseudolog.o pseudo_client.o pseudo_ipc.o \
+$(PSEUDOLOG): pseudolog.o $(SHOBJS) $(DBOBJS) pseudo_client.o pseudo_client_scanf.o pseudo_ipc.o | $(BIN)
+	$(CC) $(CFLAGS) $(CFLAGS_PSEUDO) -o $(PSEUDOLOG) pseudolog.o pseudo_client.o pseudo_client_scanf.o pseudo_ipc.o \
 		$(DBOBJS) $(SHOBJS) $(LDFLAGS) $(DB_LDFLAGS) $(CLIENT_LDFLAGS)
 
 pseudodb: $(PSEUDODB)
@@ -119,9 +119,9 @@ $(PSEUDODB): pseudodb.o $(SHOBJS) $(DBOBJS) pseudo_ipc.o | $(BIN)
 
 libpseudo: $(LIBPSEUDO)
 
-$(LIBPSEUDO): $(WRAPOBJS) pseudo_client.o pseudo_ipc.o $(SHOBJS) | $(LIB)
+$(LIBPSEUDO): $(WRAPOBJS) pseudo_client.o pseudo_client_scanf.o pseudo_ipc.o $(SHOBJS) | $(LIB)
 	$(CC) $(CFLAGS) $(CFLAGS_PSEUDO) -shared -o $(LIBPSEUDO) \
-		pseudo_client.o pseudo_ipc.o \
+		pseudo_client.o pseudo_client_scanf.o pseudo_ipc.o \
 		$(WRAPOBJS) $(SHOBJS) $(LDFLAGS) $(CLIENT_LDFLAGS)
 
 # *everything* now relies on stuff that's generated in the
@@ -135,6 +135,8 @@ pseudo_client.o pseudo_server.o pseudo_ipc.o: pseudo_ipc.h
 
 pseudo_client.o: pseudo_client.h
 
+pseudo_client_scanf.o: pseudo_client.h
+
 pseudo_server.o: pseudo_server.h
 
 tables: enums/*.in maketables templatefile.py $(TABLES)
diff --git a/ports/unix/guts/linkat.c b/ports/unix/guts/linkat.c
index 7d8dff4..e1712a9 100644
--- a/ports/unix/guts/linkat.c
+++ b/ports/unix/guts/linkat.c
@@ -55,7 +55,7 @@
 		errno = ENOSYS;
 		return -1;
 #endif
-		tmpfile_fd = atoi(oldpath + 14);
+		tmpfile_fd = pseudo_atoi_wrapper(oldpath + 14);
 		// call actual link
 		rc = real_linkat(AT_FDCWD, oldpath, AT_FDCWD, newpath, AT_SYMLINK_FOLLOW);
 	} else
diff --git a/pseudo.c b/pseudo.c
index e98e5d6..132d24a 100644
--- a/pseudo.c
+++ b/pseudo.c
@@ -212,7 +212,7 @@ main(int argc, char *argv[]) {
 			opt_S = 1;
 			break;
 		case 't': /* timeout */
-			pseudo_server_timeout = strtol(optarg, &s, 10);
+			pseudo_server_timeout = pseudo_strtol_wrapper(optarg, &s, 10);
 			if (*s && !isspace(*s)) {
 				pseudo_diag("Timeout must be an integer value.\n");
 				usage(EXIT_FAILURE);
diff --git a/pseudo.h b/pseudo.h
index 4b5eaab..b6c13f2 100644
--- a/pseudo.h
+++ b/pseudo.h
@@ -85,6 +85,10 @@ extern int pseudo_etc_file(const char *filename, char *realname, int flags, cons
 extern void pseudo_stat32_from64(struct stat *, const struct stat64 *);
 extern void pseudo_stat64_from32(struct stat64 *, const struct stat *);
 
+extern long pseudo_strtol_wrapper(const char *, char **, int);
+extern long long pseudo_strtoll_wrapper(const char *, char **, int);
+extern int pseudo_atoi_wrapper(const char *);
+
 extern char *pseudo_version;
 
 #ifndef PSEUDO_BINDIR
diff --git a/pseudo_client.c b/pseudo_client.c
index a03d6b1..1cc7a92 100644
--- a/pseudo_client.c
+++ b/pseudo_client.c
@@ -614,7 +614,7 @@ pseudo_init_client(void) {
 			 * at all.
 			 */
 			if (*env) {
-				pseudo_nosymlinkexp = strtol(env, &endptr, 10);
+				pseudo_nosymlinkexp = pseudo_strtol_wrapper(env, &endptr, 10);
 				if (*endptr)
 					pseudo_nosymlinkexp = 1;
 			} else {
@@ -624,20 +624,9 @@ pseudo_init_client(void) {
 			pseudo_nosymlinkexp = 0;
 		}
 		free(env);
-		env = pseudo_get_value("PSEUDO_UIDS");
-		if (env)
-			sscanf(env, "%d,%d,%d,%d",
-				&pseudo_ruid, &pseudo_euid,
-				&pseudo_suid, &pseudo_fuid);
-		free(env);
-
-		env = pseudo_get_value("PSEUDO_GIDS");
-		if (env)
-			sscanf(env, "%d,%d,%d,%d",
-				&pseudo_rgid, &pseudo_egid,
-				&pseudo_sgid, &pseudo_fuid);
-		free(env);
 
+		readenv_uids();
+		readenv_gids();
 		env = pseudo_get_value("PSEUDO_CHROOT");
 		if (env) {
 			pseudo_chroot = strdup(env);
@@ -1030,7 +1019,7 @@ client_spawn_server(void) {
 			pseudo_pidfile = pseudo_localstatedir_path(PSEUDO_PIDFILE);
 			fp = fopen(pseudo_pidfile, "r");
 			if (fp) {
-				if (fscanf(fp, "%d", &server_pid) != 1) {
+				if (read_pidfile(fp, &server_pid) != 1) {
 					pseudo_debug(PDBGF_CLIENT, "Opened server PID file, but didn't get a pid.\n");
 				}
 				fclose(fp);
@@ -1295,7 +1284,7 @@ pseudo_client_setup(void) {
 	fp = fopen(pseudo_pidfile, "r");
 	free(pseudo_pidfile);
 	if (fp) {
-		if (fscanf(fp, "%d", &server_pid) != 1) {
+		if (read_pidfile(fp, &server_pid) != 1) {
 			pseudo_debug(PDBGF_CLIENT, "Opened server PID file, but didn't get a pid.\n");
 		}
 		fclose(fp);
diff --git a/pseudo_client.h b/pseudo_client.h
index d7944ce..e963d95 100644
--- a/pseudo_client.h
+++ b/pseudo_client.h
@@ -74,6 +74,10 @@ extern int pseudo_nosymlinkexp;
 
 extern int pseudo_umask;
 
+extern void readenv_uids(void);
+extern void readenv_gids(void);
+extern int read_pidfile(FILE *, int *);
+
 /* Root can read and write files, and enter directories which have no
  * read, write, or execute permissions.  (But can't execute files without
  * execute permissions!)
diff --git a/pseudo_client_scanf.c b/pseudo_client_scanf.c
new file mode 100644
index 0000000..4a55d5d
--- /dev/null
+++ b/pseudo_client_scanf.c
@@ -0,0 +1,39 @@
+#include <stdio.h>
+#include "pseudo.h"
+#include "pseudo_ipc.h"
+#include "pseudo_client.h"
+
+/*
+ * glibc 2.38 would include  __isoc23_strtol and similar symbols if _GNU_SOURCE
+ * is used. We have to set that for other definitions so delcare this wrapper
+ * in a context where we don't have that set.
+ *
+ * We need to wrap strtol, strtoll, atoi, fscanf and sscanf.
+ */
+
+void readenv_uids(void)
+{
+	char *env;
+	env = pseudo_get_value("PSEUDO_UIDS");
+	if (env)
+		sscanf(env, "%d,%d,%d,%d",
+			&pseudo_ruid, &pseudo_euid,
+			&pseudo_suid, &pseudo_fuid);
+	free(env);
+}
+
+void readenv_gids(void)
+{
+	char *env;
+	env = pseudo_get_value("PSEUDO_GIDS");
+	if (env)
+		sscanf(env, "%d,%d,%d,%d",
+			&pseudo_rgid, &pseudo_egid,
+			&pseudo_sgid, &pseudo_fuid);
+	free(env);
+}
+
+int read_pidfile(FILE *fp, int *server_pid)
+{
+	return fscanf(fp, "%d", server_pid);
+}
diff --git a/pseudo_util.c b/pseudo_util.c
index 24115ff..081b8d2 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -229,7 +229,7 @@ pseudo_init_util(void) {
 	env = pseudo_get_value("PSEUDO_DEBUG");
 	if (env) {
 		int i;
-		int level = atoi(env);
+		int level = pseudo_atoi_wrapper(env);
 		if (level > 0) {
 			for (i = 0; i < level; ++i) {
 				pseudo_debug_verbose();
diff --git a/pseudolog.c b/pseudolog.c
index ad04753..44f7dbf 100644
--- a/pseudolog.c
+++ b/pseudolog.c
@@ -452,7 +452,7 @@ plog_trait(int opt, char *string) {
 	case PSQF_GID:
 	case PSQF_INODE:
 	case PSQF_UID:
-		new_trait->data.ivalue = strtoll(string, &endptr, 0);
+		new_trait->data.ivalue = pseudo_strtoll_wrapper(string, &endptr, 0);
 		if (*endptr) {
 			pseudo_diag("Unexpected garbage after number (%llu): '%s'\n",
 				new_trait->data.ivalue, endptr);
@@ -462,7 +462,7 @@ plog_trait(int opt, char *string) {
 		break;
 	case PSQF_MODE:
 	case PSQF_PERM:
-		new_trait->data.ivalue = strtoll(string, &endptr, 8);
+		new_trait->data.ivalue = pseudo_strtoll_wrapper(string, &endptr, 8);
 		if (!*endptr) {
 			break;
 		}
diff --git a/strtol.c b/strtol.c
new file mode 100644
index 0000000..258f02f
--- /dev/null
+++ b/strtol.c
@@ -0,0 +1,26 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include "pseudo.h"
+
+/*
+ * glibc 2.38 would include  __isoc23_strtol and similar symbols if _GNU_SOURCE
+ * is used. We have to set that for other definitions so delcare this wrapper
+ * in a context where we don't have that set.
+ *
+ * We need to wrap strtol, strtoll, atoi, fscanf and sscanf.
+ */
+
+int pseudo_atoi_wrapper(const char *nptr)
+{
+	return atoi(nptr);
+}
+
+long pseudo_strtol_wrapper(const char *nptr, char **endptr, int base)
+{
+	return strtol(nptr, endptr, base);
+}
+
+long long pseudo_strtoll_wrapper(const char *nptr, char **endptr, int base)
+{
+	return strtoll(nptr, endptr, base);
+}

