Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB082C44511
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 00:46:33 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.82802.1783039583796474879
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Jul 2026 17:46:24 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6630kJ14069650;
	Thu, 2 Jul 2026 19:46:21 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, frezidok1@gmail.com
Subject: [pseudo][PATCH 05/23] pseudo_db: Change pseudo_diag() calls to appropriate macros
Date: Thu,  2 Jul 2026 19:46:00 -0500
Message-Id: <1783039578-31531-6-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jul 2026 00:46:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4366

From: Dmitry Sakhonchik <frezidok1@gmail.com>

Implements [YOCTO #12141]

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 pseudo_db.c | 122 ++++++++++++++++++++++++++--------------------------
 1 file changed, 61 insertions(+), 61 deletions(-)

diff --git a/pseudo_db.c b/pseudo_db.c
index 6a33f20..6945a83 100644
--- a/pseudo_db.c
+++ b/pseudo_db.c
@@ -27,7 +27,7 @@
 #ifdef NPROFILE
 void xProfile(void * pArg, const char * pQuery, sqlite3_uint64 pTimeTaken)
 {
-       pseudo_diag("profile: %lld %s\n", pTimeTaken, pQuery);
+       pseudo_info("profile: %lld %s\n", pTimeTaken, pQuery);
 }
 #endif
 
@@ -647,7 +647,7 @@ cleanup_db(void) {
 	localtime_r(&stamp.tv_sec, &stamp_tm);
 	strftime(datebuf, 64, "%H:%M:%S", &stamp_tm);
 
-	pseudo_diag("db cleanup for server shutdown, %s.%03d\n",
+	pseudo_info("db cleanup for server shutdown, %s.%03d\n",
 		datebuf, (int) (stamp.tv_usec / 1000));
 #ifdef USE_MEMORY_DB
         if (real_file_db) {
@@ -657,7 +657,7 @@ cleanup_db(void) {
 	gettimeofday(&stamp, NULL);
 	localtime_r(&stamp.tv_sec, &stamp_tm);
 	strftime(datebuf, 64, "%H:%M:%S", &stamp_tm);
-	pseudo_diag("memory-to-file backup complete, %s.%03d.\n",
+	pseudo_info("memory-to-file backup complete, %s.%03d.\n",
 		datebuf, (int) (stamp.tv_usec / 1000));
 #endif
 	if (file_db)
@@ -667,7 +667,7 @@ cleanup_db(void) {
 	gettimeofday(&stamp, NULL);
 	localtime_r(&stamp.tv_sec, &stamp_tm);
 	strftime(datebuf, 64, "%H:%M:%S", &stamp_tm);
-	pseudo_diag("db cleanup finished, %s.%03d\n",
+	pseudo_info("db cleanup finished, %s.%03d\n",
 		datebuf, (int) (stamp.tv_usec / 1000));
 }
 
@@ -704,7 +704,7 @@ get_db(struct database_info *dbinfo) {
                 rc = sqlite3_open(dbfile, &db);
 	free(dbfile);
 	if (rc) {
-		pseudo_diag("Failed: %s\n", sqlite3_errmsg(db));
+		pseudo_error("Failed: %s\n", sqlite3_errmsg(db));
 		sqlite3_close(db);
 		*(dbinfo->db) = NULL;
 		return 1;
@@ -733,7 +733,7 @@ get_db(struct database_info *dbinfo) {
 		"ORDER BY name;";
 	rc = sqlite3_get_table(db, sql, &results, &rows, &columns, &errmsg);
 	if (rc) {
-		pseudo_diag("Failed: %s\n", errmsg);
+		pseudo_error("Failed: %s\n", errmsg);
 	} else {
 		rc = make_tables(db, dbinfo->tables, dbinfo->indexes, dbinfo->migrations, results, rows);
 		sqlite3_free_table(results);
@@ -760,7 +760,7 @@ get_dbs(void) {
 #endif
 	for (i = 0; db_infos[i].db; ++i) {
 		if (get_db(&db_infos[i])) {
-			pseudo_diag("Error getting '%s' database.\n",
+			pseudo_error("Error getting '%s' database.\n",
 				db_infos[i].pathname);
 			err = 1;
 		}
@@ -780,12 +780,12 @@ pdb_log_traits(pseudo_query_t *traits) {
 	int rc;
 
 	if (!log_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return 1;
 	}
 	e = calloc(1, sizeof(*e));
 	if (!e) {
-		pseudo_diag("can't allocate space for log entry.");
+		pseudo_error("can't allocate space for log entry.");
 		return 1;
 	}
 	for (trait = traits; trait; trait = trait->next) {
@@ -854,7 +854,7 @@ pdb_log_traits(pseudo_query_t *traits) {
 		case PSQF_ID:
 		case PSQF_ORDER:
 		default:
-			pseudo_diag("Invalid trait %s for log creation.\n",
+			pseudo_error("Invalid trait %s for log creation.\n",
 				pseudo_query_field_name(trait->field));
 			free(e);
 			return 1;
@@ -878,7 +878,7 @@ pdb_log_entry(log_entry *e) {
 	int rc;
 
 	if (!log_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return 1;
 	}
 
@@ -976,7 +976,7 @@ pdb_log_msg(pseudo_sev_t severity, pseudo_msg_t *msg, const char *program, const
 	}
 
 	if (!log_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return 1;
 	}
 
@@ -1062,7 +1062,7 @@ frag(buffer *b, char *fmt, ...) {
 	int rc;
 
 	if (!b) {
-		pseudo_diag("frag called without buffer.\n");
+		pseudo_error("frag called without buffer.\n");
 		return -1;
 	}
 	curlen = b->tail - b->data;
@@ -1075,7 +1075,7 @@ frag(buffer *b, char *fmt, ...) {
 			newlen *= 2;
 		char *newbuf = malloc(newlen);
 		if (!newbuf) {
-			pseudo_diag("failed to allocate SQL buffer.\n");
+			pseudo_error("failed to allocate SQL buffer.\n");
 			return -1;
 		}
 		memcpy(newbuf, b->data, curlen + 1);
@@ -1088,7 +1088,7 @@ frag(buffer *b, char *fmt, ...) {
 		rc = vsnprintf(b->tail, b->buflen - curlen, fmt, ap);
 		va_end(ap);
 		if ((rc > 0) && ((size_t) rc >= (b->buflen - curlen))) {
-			pseudo_diag("tried to reallocate larger buffer, failed.  giving up.\n");
+			pseudo_error("tried to reallocate larger buffer, failed.  giving up.\n");
 			return -1;
 		}
 	}
@@ -1110,24 +1110,24 @@ pdb_query(char *stmt_type, pseudo_query_t *traits, unsigned long fields, int uni
 	static buffer *sql;
 
 	if (!log_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return NULL;
 	}
 
 	if (!stmt_type) {
-		pseudo_diag("can't prepare a statement without a type.\n");
+		pseudo_warning("can't prepare a statement without a type.\n");
 	}
 
 	if (!sql) {
 		sql = malloc(sizeof *sql);
 		if (!sql) {
-			pseudo_diag("can't allocate SQL buffer.\n");
+			pseudo_error("can't allocate SQL buffer.\n");
 			return NULL;
 		}
 		sql->buflen = 512;
 		sql->data = malloc(sql->buflen);
 		if (!sql->data) {
-			pseudo_diag("can't allocate SQL text buffer.\n");
+			pseudo_error("can't allocate SQL text buffer.\n");
 			free(sql);
 			sql = 0;
 			return NULL;
@@ -1193,7 +1193,7 @@ pdb_query(char *stmt_type, pseudo_query_t *traits, unsigned long fields, int uni
 			case PSQT_LIKE:
 			case PSQT_NOTLIKE:
 			case PSQT_SQLPAT:
-				pseudo_diag("Error:  Can't use a LIKE match on non-text fields.\n");
+				pseudo_error("Can't use a LIKE match on non-text fields.\n");
 				return 0;
 				break;
 			default:
@@ -1210,7 +1210,7 @@ pdb_query(char *stmt_type, pseudo_query_t *traits, unsigned long fields, int uni
 			case PSQT_LIKE:
 			case PSQT_NOTLIKE:
 			case PSQT_SQLPAT:
-				pseudo_diag("Error:  Can't use a LIKE match on non-text fields.\n");
+				pseudo_error("Error:  Can't use a LIKE match on non-text fields.\n");
 				return 0;
 				break;
 			default:
@@ -1235,7 +1235,7 @@ pdb_query(char *stmt_type, pseudo_query_t *traits, unsigned long fields, int uni
 				order_dir = "ASC";
 				break;
 			default:
-				pseudo_diag("Ordering must be < or >.\n");
+				pseudo_error("Ordering must be < or >.\n");
 				return 0;
 				break;
 			}
@@ -1245,7 +1245,7 @@ pdb_query(char *stmt_type, pseudo_query_t *traits, unsigned long fields, int uni
 			case PSQT_LIKE:
 			case PSQT_NOTLIKE:
 			case PSQT_SQLPAT:
-				pseudo_diag("Error:  Can't use a LIKE match on non-text fields.\n");
+				pseudo_error("Can't use a LIKE match on non-text fields.\n");
 				return 0;
 				break;
 			default:
@@ -1300,7 +1300,7 @@ pdb_query(char *stmt_type, pseudo_query_t *traits, unsigned long fields, int uni
 			sqlite3_bind_int64(stmt, field++, trait->data.ivalue);
 			break;
 		default:
-			pseudo_diag("Inexplicably invalid field type %d\n", trait->field);
+			pseudo_error("Inexplicably invalid field type %d\n", trait->field);
 			sqlite3_finalize(stmt);
 			return NULL;
 		}
@@ -1322,7 +1322,7 @@ pdb_delete(pseudo_query_t *traits, unsigned long fields) {
 			dberr(log_db, "deletion failed");
 			return -1;
 		} else {
-			pseudo_diag("Deleted records, vacuuming log database (may take a while).\n");
+			pseudo_info("Deleted records, vacuuming log database (may take a while).\n");
 			/* we can't do anything about it if this fails... */
 			sqlite3_exec(log_db, "VACUUM;", NULL, NULL, NULL);
 		}
@@ -1347,7 +1347,7 @@ pdb_history(pseudo_query_t *traits, unsigned long fields, int unique) {
 			h->fields = fields;
 			h->stmt = stmt;
 		} else {
-			pseudo_diag("failed to allocate memory for log_history\n");
+			pseudo_error("failed to allocate memory for log_history\n");
 			sqlite3_finalize(stmt);
 		}
 		return h;
@@ -1378,7 +1378,7 @@ pdb_history_entry(log_history h) {
 	}
 	l = calloc(1, sizeof(log_entry));
 	if (!l) {
-		pseudo_diag("couldn't allocate log entry.\n");
+		pseudo_error("couldn't allocate log entry.\n");
 		return 0;
 	}
 
@@ -1449,12 +1449,12 @@ pdb_history_entry(log_history h) {
 		case PSQF_ORDER:
 		case PSQF_FTYPE:
 		case PSQF_PERM:
-			pseudo_diag("field %s should not be in the fields list.\n",
+			pseudo_warning("field %s should not be in the fields list.\n",
 				pseudo_query_field_name(f));
 			return 0;
 			break;
 		default:
-			pseudo_diag("unknown field %d\n", f);
+			pseudo_warning("unknown field %d\n", f);
 			return 0;
 			break;
 		}
@@ -1498,7 +1498,7 @@ pdb_clear_unused_xattrs(void) {
 	int rc;
 
 	if (!file_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return;
 	}
 	if (!delete) {
@@ -1528,7 +1528,7 @@ pdb_clear_xattrs(pseudo_msg_t *msg) {
 	if (!msg)
 		return;
 	if (!file_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return;
 	}
 	if (!delete) {
@@ -1565,7 +1565,7 @@ pdb_copy_xattrs(pseudo_msg_t *oldmsg, pseudo_msg_t *msg) {
 	if (!oldmsg || !msg)
 		return;
 	if (!file_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return;
 	}
 	if (!copy) {
@@ -1596,7 +1596,7 @@ pdb_check_xattrs(pseudo_msg_t *msg) {
 	if (!msg)
 		return;
 	if (!file_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return;
 	}
 	if (!scan) {
@@ -1643,7 +1643,7 @@ pdb_link_file(pseudo_msg_t *msg) {
 		    " VALUES (?, ?, ?, ?, ?, ?, ?, 0);";
 
 	if (!file_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return 0;
 	}
 	if (!insert) {
@@ -1689,7 +1689,7 @@ pdb_unlink_file_dev(pseudo_msg_t *msg) {
 	char *sql = "DELETE FROM files WHERE dev = ? AND ino = ?;";
 
 	if (!file_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return 0;
 	}
 	if (!sql_delete) {
@@ -1724,7 +1724,7 @@ pdb_update_file_path(pseudo_msg_t *msg) {
 		"WHERE path = 'NAMELESS FILE' and dev = ? AND ino = ?;";
 
 	if (!file_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return 0;
 	}
 	if (!update) {
@@ -1759,7 +1759,7 @@ pdb_may_unlink_file(pseudo_msg_t *msg, int deleting) {
 	char *sql_mark_file = "UPDATE files SET deleting = ? WHERE path = ?;";
 
 	if (!file_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return 0;
 	}
 	if (!mark_file) {
@@ -1804,7 +1804,7 @@ pdb_cancel_unlink_file(pseudo_msg_t *msg) {
 	char *sql_mark_file = "UPDATE files SET deleting = 0 WHERE path = ?;";
 
 	if (!file_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return 0;
 	}
 	if (!mark_file) {
@@ -1846,7 +1846,7 @@ pdb_did_unlink_files(int deleting) {
 	char *sql_delete_exact = "DELETE FROM files WHERE deleting = ?;";
 
 	if (!file_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return 0;
 	}
 	if (!delete_exact) {
@@ -1857,7 +1857,7 @@ pdb_did_unlink_files(int deleting) {
 		}
 	}
 	if (deleting == 0) {
-		pseudo_diag("did_unlink_files: deleting must be non-zero.\n");
+		pseudo_error("did_unlink_files: deleting must be non-zero.\n");
 		return 0;
 	}
 	sqlite3_bind_int(delete_exact, 1, deleting);
@@ -1882,7 +1882,7 @@ pdb_did_unlink_file(char *path, pseudo_msg_t *msg, int deleting) {
 	char *sql_delete_exact = "DELETE FROM files WHERE path = ? AND deleting = ?;";
 
 	if (!file_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return 0;
 	}
 	if (!delete_exact) {
@@ -1925,7 +1925,7 @@ pdb_unlink_file(pseudo_msg_t *msg) {
 	char *sql_delete_exact = "DELETE FROM files WHERE path = ?;";
 
 	if (!file_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return 0;
 	}
 	if (!delete_exact) {
@@ -1973,7 +1973,7 @@ pdb_unlink_contents(pseudo_msg_t *msg) {
 				"(path > (? || '/') AND path < (? || '0'));";
 
 	if (!file_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return 0;
 	}
 	if (!delete_sub) {
@@ -2025,7 +2025,7 @@ pdb_rename_file(const char *oldpath, pseudo_msg_t *msg) {
 			       "WHERE (path > (? || '/') AND path < (? || '0'));";
 
 	if (!file_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return 0;
 	}
 	if (!update_exact) {
@@ -2098,7 +2098,7 @@ pdb_renumber_all(dev_t from, dev_t to) {
 		    " WHERE dev = ?;";
 
 	if (!file_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return 0;
 	}
 	if (!files_update) {
@@ -2166,7 +2166,7 @@ pdb_update_inode(pseudo_msg_t *msg) {
 	if (!oldmsg) {
 		oldmsg = malloc(sizeof(*msg) + pseudo_path_max());
 		if (!oldmsg) {
-			pseudo_diag("%s: out of memory\n", __func__);
+			pseudo_error("%s: out of memory\n", __func__);
 			return 1;
 		}
 	}
@@ -2175,7 +2175,7 @@ pdb_update_inode(pseudo_msg_t *msg) {
 		    " SET dev = ?, ino = ? "
 		    " WHERE path = ?;";
 	if (!file_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return 0;
 	}
 	if (!update) {
@@ -2189,7 +2189,7 @@ pdb_update_inode(pseudo_msg_t *msg) {
 		return 1;
 	}
 	if (!msg->pathlen) {
-		pseudo_diag("Can't update the inode of a file without its path.\n");
+		pseudo_error("Can't update the inode of a file without its path.\n");
 		return 1;
 	}
 	memcpy(oldmsg, msg, sizeof(*msg) + msg->pathlen);
@@ -2240,7 +2240,7 @@ pdb_update_file(pseudo_msg_t *msg) {
 		    " WHERE dev = ? AND ino = ?;";
 
 	if (!file_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return 0;
 	}
 	if (!update) {
@@ -2281,7 +2281,7 @@ pdb_find_file_exact(pseudo_msg_t *msg) {
 	char *sql = "SELECT * FROM files WHERE path = ? AND dev = ? AND ino = ?;";
 
 	if (!file_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return 0;
 	}
 	if (!select) {
@@ -2332,7 +2332,7 @@ pdb_find_file_path(pseudo_msg_t *msg) {
 	char *sql = "SELECT * FROM files WHERE path = ?;";
 
 	if (!file_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return 1;
 	}
 	if (!select) {
@@ -2389,7 +2389,7 @@ pdb_get_file_path(pseudo_msg_t *msg) {
 	char *response;
 
 	if (!file_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return 0;
 	}
 	if (!select) {
@@ -2438,7 +2438,7 @@ pdb_find_file_dev(pseudo_msg_t *msg, char **path) {
 	char *sql = "SELECT * FROM files WHERE dev = ? AND ino = ?;";
 
 	if (!file_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return 0;
 	}
 	if (!select) {
@@ -2492,7 +2492,7 @@ pdb_get_xattr(pseudo_msg_t *msg, char **value, size_t *len) {
 	char *sql = "SELECT value FROM xattrs WHERE dev  = ? AND ino = ? AND name = ?;";
 
 	if (!file_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return 0;
 	}
 	if (!select) {
@@ -2523,7 +2523,7 @@ pdb_get_xattr(pseudo_msg_t *msg, char **value, size_t *len) {
 			 */
 			*value = malloc(length);
 			if (!*value) {
-				pseudo_diag("%s: out of memory\n", __func__);
+				pseudo_error("%s: out of memory\n", __func__);
 				sqlite3_reset(select);
 				sqlite3_clear_bindings(select);
 				return 1;
@@ -2561,7 +2561,7 @@ pdb_list_xattr(pseudo_msg_t *msg, char **value, size_t *len) {
 	char *sql = "SELECT name FROM xattrs WHERE dev = ? AND ino = ? ORDER BY name;";
 
 	if (!file_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return 0;
 	}
 	if (!select) {
@@ -2615,7 +2615,7 @@ pdb_remove_xattr(pseudo_msg_t *msg, char *value, size_t len) {
 	char *sql = "DELETE FROM xattrs WHERE dev = ? AND ino = ? AND name = ?;";
 
 	if (!file_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return 0;
 	}
 	if (!delete) {
@@ -2656,7 +2656,7 @@ pdb_set_xattr(pseudo_msg_t *msg, char *value, size_t len, int flags) {
 	size_t vlen;
 
 	if (!file_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return 0;
 	}
 	if (!select) {
@@ -2769,7 +2769,7 @@ pdb_find_file_ino(pseudo_msg_t *msg) {
 	char *sql = "SELECT * FROM files WHERE ino = ?;";
 
 	if (!file_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return 0;
 	}
 	if (!select) {
@@ -2813,7 +2813,7 @@ pdb_files(void) {
 	pdb_file_list l;
 
 	if (!file_db && get_dbs()) {
-		pseudo_diag("%s: database error.\n", __func__);
+		pseudo_error("%s: database error.\n", __func__);
 		return 0;
 	}
 
@@ -2852,7 +2852,7 @@ pdb_file(pdb_file_list l) {
 	s = sqlite3_column_text(l->stmt, column++);
 	m = pseudo_msg_new(0, (const char *) s);
 	if (!m) {
-		pseudo_diag("couldn't allocate file message.\n");
+		pseudo_error("couldn't allocate file message.\n");
 		return NULL;
 	}
 	pseudo_debug(PDBGF_DB, "pdb_file: '%s'\n", s ? (const char *) s : "<nil>");
-- 
2.53.0


