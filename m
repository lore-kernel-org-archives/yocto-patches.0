Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9EACD8CB2
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 11:47:16 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18629.1781092028500604725
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Jun 2026 04:47:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=CIZyaF0f;
 spf=pass (domain: gmail.com, ip: 209.85.208.44, mailfrom: frezidok1@gmail.com)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6914a658115so5934844a12.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jun 2026 04:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781092027; x=1781696827; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oI5UnFtmAAfyctZhRXoeMQf982EOf8PORKjKasij5vk=;
        b=CIZyaF0fKm+L7DFGIEX95W2LxZ4pfmKRwiZRPp4AzX7ErVuI+9No36/D38gC1Fgpol
         TDgeTTZBRCU9souchbVXLLT7SPJ1j1FsVsxN+vT6AMUh4MpAeuM0XG6Hmjpyd6Mdw3Wb
         ElOcaEgE5aZ4Y8+zTHneGhcrXbf9BWUKHmcxWK0/wpOGbetgdKKUy9W9Cm9vBMuKcm41
         m5SzVVC/7vhm6bOYVU4gc48CjrCxtdNPanmoVNQEOU+pJR571FltG0hbCoP3/VTYlJuK
         ksuUvjvFqyIUJ3nx96v9f0GinAryuQ82KPcjeaDKQjJ3KOfPozCKjtfTween5NK2agpA
         obSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781092027; x=1781696827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oI5UnFtmAAfyctZhRXoeMQf982EOf8PORKjKasij5vk=;
        b=dELcpAiuIW48Q/l1O0Hy3Tzbpw6sVh2dj7+QewOJFNnd85XiKgKo2bx2zQAjXb8upB
         SlD8I48XqnqxryJwv97HPUDqregUiSSNI9ycBCCdLMVrvEVFqy3UT3CTeKxV1L1Hiu7d
         lvWOtSSlSM3dLTQ6h599E+1nWVV8AeTR6xhhaXg3EgrBHf5/zWNgMxnajDa/ElraCTd2
         HYR5mjuqiywePpX4PUFQkIy3jGqXEuidvC1caIDjeq90Id1ib5HVnjnj4f0F6JyYw8Ul
         0mfjQ3+XTnbF6QxEGcCU3TweXlw9QFLJC9o4pgcDTla6F5g0chlPQzQ2LQWxght7gYI8
         KbwQ==
X-Gm-Message-State: AOJu0YwLG3ISUCyNifOESZ+ooVI2pKecvIjijhY0BHThr42AgKzurhrf
	EFDsMhiBb23DiWIUNCciWT6oqr6ErFJw/xmqQKMN3Cni1BXl2aePba8xE5ukNqu8
X-Gm-Gg: Acq92OHsLpC8Cw3sbC4cQdlsqJQnEK1qsiGCVpeo8OZ2/eQO/JhJwkN+Q+/srRnd/S7
	nNRhIwvunqX/ISVRnZ4Q35QXdPvmHEmcZJYckmlMenH2g2MoftaRXfsB97jwDiO5kvixj9Uznx3
	LS0Ya7ilDZhykG+ZpuQBa1duhuRp4rzZHIhF2NJkaopv7o23M00jlw+wGjkwOtqODVGJEhWWc5s
	6jyFPYx1eIOzDEiSUFlCnFxf9I1gWkEYVurvXp1kw87Pk8afY+DcRQAb4JZGLk7sW1WJYF/RisE
	1nIAa2PuDPSsoXHi9+Fl5+Qw1H8geXSRFawXctjErPPtTXt+n3CdrlBYNGl7tnzbMI3Avw+yx9v
	QcX8QqP9IV2FHvqTIQ61eDug0F0mFcbVh6/s+JrDd0xiNg47+WrbiL+Br1hH6r/kiTNYrNz5yNu
	DQlUpj/r1mSXomTNSogKz99fJx1bEJ
X-Received: by 2002:a05:6402:4506:b0:68a:88cd:eb22 with SMTP id 4fb4d7f45d1cf-68fa535d734mr11624557a12.26.1781092026483;
        Wed, 10 Jun 2026 04:47:06 -0700 (PDT)
Received: from ubuntu1.. ([194.87.83.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6912faea64dsm5997164a12.19.2026.06.10.04.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:47:05 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH 5/8] pseudo.c: Change pseudo_diag() calls to appropriate macros
Date: Wed, 10 Jun 2026 14:46:07 +0300
Message-ID: <20260610114610.60776-5-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610114610.60776-1-frezidok1@gmail.com>
References: <20260610114610.60776-1-frezidok1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jun 2026 11:47:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4196

From: Dmitry Sakhonchik <frezidok1@gmail.com>

Implements [YOCTO #12141]

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
---
 pseudo.c | 100 +++++++++++++++++++++++++++----------------------------
 1 file changed, 50 insertions(+), 50 deletions(-)

diff --git a/pseudo.c b/pseudo.c
index e5fe5cf..11112dd 100644
--- a/pseudo.c
+++ b/pseudo.c
@@ -105,8 +105,8 @@ main(int argc, char *argv[]) {
 		pseudo_debug(PDBGF_SERVER, "[server %d] can't run daemon with libpseudo in %s\n", getpid(), PRELINK_LIBRARIES);
 		s = pseudo_get_value("PSEUDO_UNLOAD");
 		if (s) {
-			pseudo_diag("pseudo: I can't seem to make %s go away.  Sorry.\n", PRELINK_LIBRARIES);
-			pseudo_diag("pseudo: %s: %s\n", PRELINK_LIBRARIES, ld_env);
+			pseudo_error("pseudo: I can't seem to make %s go away.  Sorry.\n", PRELINK_LIBRARIES);
+			pseudo_error("pseudo: %s: %s\n", PRELINK_LIBRARIES, ld_env);
 			exit(PSEUDO_EXIT_PSEUDO_LOADED);
 		}
 		free(s);
@@ -155,7 +155,7 @@ main(int argc, char *argv[]) {
 		case 'i': /* renumber devices, assuming stable inodes */
 			s = PSEUDO_ROOT_PATH(AT_FDCWD, optarg, 0);
 			if (!s) {
-				pseudo_diag("Can't resolve path '%s'\n", optarg);
+				pseudo_error("Can't resolve path '%s'\n", optarg);
 				usage(EXIT_FAILURE);
 			}
 			opt_i = strdup(s);
@@ -168,7 +168,7 @@ main(int argc, char *argv[]) {
 		case 'm': /* move from... (see also 'M') */
 			s = PSEUDO_ROOT_PATH(AT_FDCWD, optarg, 0);
 			if (!s) {
-				pseudo_diag("Can't resolve move-from path '%s'\n", optarg);
+				pseudo_error("Can't resolve move-from path '%s'\n", optarg);
 				usage(EXIT_FAILURE);
 			}
 			opt_m = strdup(s);
@@ -176,7 +176,7 @@ main(int argc, char *argv[]) {
 		case 'M': /* move to... (see also 'm') */
 			s = PSEUDO_ROOT_PATH(AT_FDCWD, optarg, 0);
 			if (!s) {
-				pseudo_diag("Can't resolve move-to path '%s'\n", optarg);
+				pseudo_error("Can't resolve move-to path '%s'\n", optarg);
 				usage(EXIT_FAILURE);
 			}
 			opt_M = strdup(s);
@@ -184,7 +184,7 @@ main(int argc, char *argv[]) {
 		case 'p': /* passwd file path */
 			s = PSEUDO_ROOT_PATH(AT_FDCWD, optarg, AT_SYMLINK_NOFOLLOW);
 			if (!s) {
-				pseudo_diag("Can't resolve passwd path '%s'\n", optarg);
+				pseudo_error("Can't resolve passwd path '%s'\n", optarg);
 				usage(EXIT_FAILURE);
 			}
 			pseudo_set_value("PSEUDO_PASSWD", s);
@@ -192,7 +192,7 @@ main(int argc, char *argv[]) {
 		case 'P': /* prefix */
 			s = PSEUDO_ROOT_PATH(AT_FDCWD, optarg, AT_SYMLINK_NOFOLLOW);
 			if (!s) {
-				pseudo_diag("Can't resolve prefix path '%s'\n", optarg);
+				pseudo_error("Can't resolve prefix path '%s'\n", optarg);
 				usage(EXIT_FAILURE);
 			}
 			pseudo_set_value("PSEUDO_PREFIX", s);
@@ -201,7 +201,7 @@ main(int argc, char *argv[]) {
 		case 'R':	/* pseudo root path */
 			s = PSEUDO_ROOT_PATH(AT_FDCWD, optarg, AT_SYMLINK_NOFOLLOW);
 			if (!s) {
-				pseudo_diag("Can't resolve root path '%s'\n", optarg);
+				pseudo_error("Can't resolve root path '%s'\n", optarg);
 				usage(EXIT_FAILURE);
 			}
 			pseudo_set_value("PSEUDO_CHROOT", s);
@@ -214,7 +214,7 @@ main(int argc, char *argv[]) {
 		case 't': /* timeout */
 			pseudo_server_timeout = pseudo_strtol_wrapper(optarg, &s, 10);
 			if (*s && !isspace(*s)) {
-				pseudo_diag("Timeout must be an integer value.\n");
+				pseudo_error("Timeout must be an integer value.\n");
 				usage(EXIT_FAILURE);
 			}
 			optptr += snprintf(optptr, pseudo_path_max() - (optptr - opts),
@@ -239,7 +239,7 @@ main(int argc, char *argv[]) {
 			break;
 		case '?':
 		default:
-			pseudo_diag("unknown/invalid argument (option '%c').\n", optopt);
+			pseudo_error("unknown/invalid argument (option '%c').\n", optopt);
 			usage(EXIT_FAILURE);
 			break;
 		}
@@ -250,7 +250,7 @@ main(int argc, char *argv[]) {
 
 	s = pseudo_get_prefix(argv[0]);
 	if (!s) {
-		pseudo_diag("Can't figure out prefix.  Set PSEUDO_PREFIX or invoke with full path.\n");
+		pseudo_error("Can't figure out prefix.  Set PSEUDO_PREFIX or invoke with full path.\n");
 		exit(PSEUDO_EXIT_PSEUDO_PREFIX);
 	}
 	free(s);
@@ -261,29 +261,29 @@ main(int argc, char *argv[]) {
 		pseudo_msg_t *msg;
 		int rc;
 		if (!(opt_m && opt_M)) {
-			pseudo_diag("You cannot move the database without specifying from and to.\n");
+			pseudo_error("You cannot move the database without specifying from and to.\n");
 			exit(EXIT_FAILURE);
 		}
 		if (stat(opt_M, &buf) < 0) {
-			pseudo_diag("stat of '%s' failed: %s\n",
+			pseudo_error("stat of '%s' failed: %s\n",
 				opt_M, strerror(errno));
-			pseudo_diag("The directory the database is being moved to must exist.\n");
+			pseudo_error("The directory the database is being moved to must exist.\n");
 			exit(EXIT_FAILURE);
 		}
 		msg = pseudo_msg_new(0, opt_M);
 		if (!msg) {
-			pseudo_diag("Can't allocate message structure.\n");
+			pseudo_error("Can't allocate message structure.\n");
 			exit(EXIT_FAILURE);
 		}
 		rc = pdb_rename_file(opt_m, msg);
 		free(msg);
 		if (rc < 0) {
-			pseudo_diag("Warning: Database move may have failed.\n");
-			pseudo_diag("To try to restore, you can reverse the move.\n");
-			pseudo_diag("To commit to this anyway, run pseudo -C to check the database.\n");
+			pseudo_warning("Database move may have failed.\n");
+			pseudo_warning("To try to restore, you can reverse the move.\n");
+			pseudo_warning("To commit to this anyway, run pseudo -C to check the database.\n");
 			exit(EXIT_FAILURE);
 		}
-		pseudo_diag("Rename looked okay, running database sanity check.\n");
+		pseudo_info("Rename looked okay, running database sanity check.\n");
 		opt_C = 1;
 	}
 
@@ -292,32 +292,32 @@ main(int argc, char *argv[]) {
 		struct stat buf;
 		pseudo_msg_t *msg;
 		if (stat(opt_i, &buf) < 0) {
-			pseudo_diag("stat of '%s' failed: %s\n",
+			pseudo_error("stat of '%s' failed: %s\n",
 				opt_i, strerror(errno));
-			pseudo_diag("The file used to renumber the database must exist.\n");
+			pseudo_error("The file used to renumber the database must exist.\n");
 			exit(EXIT_FAILURE);
 		}
 		msg = pseudo_msg_new(0, opt_i);
 		if (!msg) {
-			pseudo_diag("Couldn't allocate data structure for path.\n");
+			pseudo_error("Couldn't allocate data structure for path.\n");
 			exit(EXIT_FAILURE);
 		}
 		if (pdb_find_file_path(msg)) {
-			pseudo_diag("Couldn't find a database entry for '%s'.\n", opt_i);
+			pseudo_error("Couldn't find a database entry for '%s'.\n", opt_i);
 			exit(EXIT_FAILURE);
 		}
 		if (buf.st_ino != msg->ino) {
-			pseudo_diag("The database inode entry for '%s' doesn't match; you must use -b.\n",
+			pseudo_error("The database inode entry for '%s' doesn't match; you must use -b.\n",
 				opt_i);
 			exit(EXIT_FAILURE);
 		}
 		rc = pdb_renumber_all(msg->dev, buf.st_dev);
 		free(msg);
 		if (rc < 0) {
-			pseudo_diag("Warning: Database renumber failed.\n");
+			pseudo_warning("Database renumber failed.\n");
 			exit(EXIT_FAILURE);
 		}
-		pseudo_diag("Renumber looked okay, running database sanity check.\n");
+		pseudo_info("Renumber looked okay, running database sanity check.\n");
 		opt_C = 1;
 	}
 
@@ -332,13 +332,13 @@ main(int argc, char *argv[]) {
 	}
 
 	if (opt_d && opt_f) {
-		pseudo_diag("You cannot run a foregrounded daemon.\n");
+		pseudo_error("You cannot run a foregrounded daemon.\n");
 		exit(PSEUDO_EXIT_PSEUDO_INVOCATION);
 	}
 
 	if (opt_f || opt_d) {
 		if (argc > optind) {
-			pseudo_diag("pseudo: running program implies spawning background daemon.\n");
+			pseudo_error("pseudo: running program implies spawning background daemon.\n");
 			exit(PSEUDO_EXIT_PSEUDO_INVOCATION);
 		}
 	} else {
@@ -347,7 +347,7 @@ main(int argc, char *argv[]) {
 
 		if (opt_r) {
 			if (chdir(opt_r) == -1) {
-				pseudo_diag("failed to chdir to '%s': %s\n",
+				pseudo_error("failed to chdir to '%s': %s\n",
 					opt_r, strerror(errno));
 				exit(EXIT_FAILURE);
 			}
@@ -378,7 +378,7 @@ main(int argc, char *argv[]) {
 				int len = strcspn(path, ":");
 				if ( snprintf(fullpath, pseudo_path_max(), "%.*s/%s",
 					len, path, argv[0]) > (int) pseudo_path_max()) {
-					pseudo_diag("pseudo: path too long.\n");
+					pseudo_error("pseudo: path too long.\n");
 					exit(EXIT_FAILURE);
 				}
 				path += len;
@@ -392,7 +392,7 @@ main(int argc, char *argv[]) {
 				}
 			}
 			if (!found) {
-				pseudo_diag("Can't find '%s' in $PATH.\n",
+				pseudo_error("Can't find '%s' in $PATH.\n",
 					argv[0]);
 				exit(EXIT_FAILURE);
 			}
@@ -401,7 +401,7 @@ main(int argc, char *argv[]) {
 
 		rc = fork();
 		if (rc == -1) {
-			pseudo_diag("pseudo: fork failed: %s\n",
+			pseudo_error("pseudo: fork failed: %s\n",
 				strerror(errno));
 			exit(EXIT_FAILURE);
 		} else {
@@ -424,7 +424,7 @@ main(int argc, char *argv[]) {
 			} else {
 				rc = execv(fullpath, argv);
 				if (rc == -1) {
-					pseudo_diag("pseudo: can't run %s: %s\n",
+					pseudo_error("pseudo: can't run %s: %s\n",
 						argv[0], strerror(errno));
 				}
 			}
@@ -615,7 +615,7 @@ pseudo_op(pseudo_msg_t *msg, const char *program, const char *tag, char **respon
 					 */
 					pdb_did_unlink_file(msg->path, NULL, by_path.deleting);
 				} else {
-					pseudo_diag("inode mismatch: '%s' ino %llu in db, %llu in request.\n",
+					pseudo_error("inode mismatch: '%s' ino %llu in db, %llu in request.\n",
 						msg->path,
 						(unsigned long long) by_path.ino,
 						(unsigned long long) msg_header.ino);
@@ -634,14 +634,14 @@ pseudo_op(pseudo_msg_t *msg, const char *program, const char *tag, char **respon
 		 * the bogus entry that we noticed.
 		 */
 		if (S_ISDIR(by_path.mode) != S_ISDIR(msg_header.mode)) {
-			pseudo_diag("dir mismatch: '%s' [%llu] db mode 0%o, header mode 0%o (unlinking db)\n",
+			pseudo_error("dir mismatch: '%s' [%llu] db mode 0%o, header mode 0%o (unlinking db)\n",
 				msg->path, (unsigned long long) by_path.ino,
 				(int) by_path.mode, (int) msg_header.mode);
 			/* unlink this path -- the inode may be in use elsewhere */
 			pdb_unlink_file(msg);
 			found_path = 0;
 		} else if (S_ISLNK(by_path.mode) != S_ISLNK(msg_header.mode)) {
-			pseudo_diag("symlink mismatch: '%s' [%llu] db mode 0%o, header mode 0%o (unlinking db)\n",
+			pseudo_error("symlink mismatch: '%s' [%llu] db mode 0%o, header mode 0%o (unlinking db)\n",
 				msg->path, (unsigned long long) by_path.ino,
 				(int) by_path.mode, (int) msg_header.mode);
 			/* unlink this path -- the inode may be in use elsewhere */
@@ -649,7 +649,7 @@ pseudo_op(pseudo_msg_t *msg, const char *program, const char *tag, char **respon
 			found_path = 0;
 		}
 		if (trailing_slash && !S_ISDIR(by_path.mode)) {
-			pseudo_diag("dir quasi-mismatch: '%s' [%llu] db mode 0%o, incoming path had trailing slash. Not unlinking.\n",
+			pseudo_error("dir quasi-mismatch: '%s' [%llu] db mode 0%o, incoming path had trailing slash. Not unlinking.\n",
 				msg->path, (unsigned long long) by_path.ino,
 				(int) by_path.mode);
 		}
@@ -713,7 +713,7 @@ pseudo_op(pseudo_msg_t *msg, const char *program, const char *tag, char **respon
 					pseudo_debug(PDBGF_FILE, "inode mismatch for '%s' -- old one was marked for deletion.\n",
 						msg->path);
 				} else {
-					pseudo_diag("path mismatch [%d link%s]: ino %llu db '%s' req '%s'.\n",
+					pseudo_error("path mismatch [%d link%s]: ino %llu db '%s' req '%s'.\n",
 						msg->nlink,
 						msg->nlink == 1 ? "" : "s",
 						(unsigned long long) msg_header.ino,
@@ -734,7 +734,7 @@ pseudo_op(pseudo_msg_t *msg, const char *program, const char *tag, char **respon
 		 * entry.  There is no way it can be right.
 		 */
 		if (S_ISDIR(by_ino.mode) != S_ISDIR(msg_header.mode)) {
-			pseudo_diag("dir err : %llu ['%s'] (db '%s') db mode 0%o, header mode 0%o (unlinking db)\n",
+			pseudo_error("dir err : %llu ['%s'] (db '%s') db mode 0%o, header mode 0%o (unlinking db)\n",
 				(unsigned long long) msg_header.ino,
 				msg->pathlen ? msg->path : "no path",
 				path_by_ino ? path_by_ino : "no path",
@@ -746,7 +746,7 @@ pseudo_op(pseudo_msg_t *msg, const char *program, const char *tag, char **respon
 			 * can ever be a symlink; the test is generic as
 			 * insurance against forgetting to fix it in a future
 			 * update. */
-			pseudo_diag("symlink err : %llu ['%s'] (db '%s') db mode 0%o, header mode 0%o (unlinking db)\n",
+			pseudo_error("symlink err : %llu ['%s'] (db '%s') db mode 0%o, header mode 0%o (unlinking db)\n",
 				(unsigned long long) msg_header.ino,
 				msg->pathlen ? msg->path : "no path",
 				path_by_ino ? path_by_ino : "no path",
@@ -771,7 +771,7 @@ pseudo_op(pseudo_msg_t *msg, const char *program, const char *tag, char **respon
 	case OP_CLOSE:
 		/* these messages are handled entirely on the client side,
 		 * as of this writing, but might be logged by accident: */
-		pseudo_diag("error: op %s sent to server.\n", pseudo_op_name(msg->op));
+		pseudo_error("op %s sent to server.\n", pseudo_op_name(msg->op));
 		break;
 	case OP_EXEC:		/* FALLTHROUGH */
 	case OP_OPEN:
@@ -785,7 +785,7 @@ pseudo_op(pseudo_msg_t *msg, const char *program, const char *tag, char **respon
 			 * ... But only if it wasn't a match on both inode *and*
 			 * path, because if it were, that would be harmless.
 			 */
-			pseudo_diag("creat for '%s' replaces existing %llu ['%s'].\n",
+			pseudo_info("creat for '%s' replaces existing %llu ['%s'].\n",
 				msg->pathlen ? msg->path : "no path",
 				(unsigned long long) by_ino.ino,
 				path_by_ino ? path_by_ino : "no path");
@@ -797,7 +797,7 @@ pseudo_op(pseudo_msg_t *msg, const char *program, const char *tag, char **respon
 			pdb_link_file(msg);
 		} else {
 			/* again, an error, but leaving it alone for now. */
-			pseudo_diag("creat ignored for existing file '%s'.\n",
+			pseudo_error("creat ignored for existing file '%s'.\n",
 				msg->pathlen ? msg->path : "no path");
 		}
 		break;
@@ -984,7 +984,7 @@ pseudo_op(pseudo_msg_t *msg, const char *program, const char *tag, char **respon
 		 * file DID NOT exist before the call.  Fix database:
 		 */
 		if (found_path) {
-			pseudo_diag("mkdir/mknod: '%s' [%llu] already existed (mode 0%o), unlinking\n",
+			pseudo_info("mkdir/mknod: '%s' [%llu] already existed (mode 0%o), unlinking\n",
 				msg->path, (unsigned long long) by_path.ino,
 				(int) by_path.mode);
 			pdb_unlink_file(msg);
@@ -1035,7 +1035,7 @@ pseudo_op(pseudo_msg_t *msg, const char *program, const char *tag, char **respon
 		pdb_remove_xattr(msg, oldpath, oldpathlen);
 		break;
 	default:
-		pseudo_diag("unknown op from client %d, op %d [%s]\n",
+		pseudo_error("unknown op from client %d, op %d [%s]\n",
 			msg->client, msg->op,
 			msg->pathlen ? msg->path : "no path");
 		break;
@@ -1110,7 +1110,7 @@ pseudo_db_check(int fix) {
 
 	l = pdb_files();
 	if (!l) {
-		pseudo_diag("Couldn't start file list, can't scan.\n");
+		pseudo_error("Couldn't start file list, can't scan.\n");
 		return EXIT_FAILURE;
 	}
 	while ((m = pdb_file(l)) != NULL) {
@@ -1123,7 +1123,7 @@ pseudo_db_check(int fix) {
 			pseudo_debug(PDBGF_DB, "Checking <%s>\n", m->path);
 			if (lstat(m->path, &buf)) {
 				if (!fix) {
-					pseudo_diag("can't stat <%s>\n", m->path);
+					pseudo_error("can't stat <%s>\n", m->path);
 					errors = EXIT_FAILURE;
 					continue;
 				} else {
@@ -1180,7 +1180,7 @@ pseudo_db_check(int fix) {
 						rc = pdb_may_unlink_file(m, magic_cookie);
 					}
 					if (rc) {
-						pseudo_diag("error updating file %s\n",
+						pseudo_error("error updating file %s\n",
 							m->path);
 						errors = EXIT_FAILURE;
 					}
@@ -1195,8 +1195,8 @@ pseudo_db_check(int fix) {
 	if (delete_some) {
 		rc = pdb_did_unlink_files(magic_cookie);
 		if (rc) {
-			pseudo_diag("error nuking mismatched files.\n");
-			pseudo_diag("database may not be fixed.\n");
+			pseudo_error("error nuking mismatched files.\n");
+			pseudo_error("database may not be fixed.\n");
 			errors = EXIT_FAILURE;
 		}
 	}

