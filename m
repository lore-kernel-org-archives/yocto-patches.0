Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D71CD8CB9
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 11:47:26 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18632.1781092038389549229
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Jun 2026 04:47:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=qSXDxsU1;
 spf=pass (domain: gmail.com, ip: 209.85.208.51, mailfrom: frezidok1@gmail.com)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-687ed9aabb3so13119638a12.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jun 2026 04:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781092037; x=1781696837; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FfiefZ2Iv6Y+bSBqRU8RJhOCQtMXaaY/t2xo867vE8=;
        b=qSXDxsU13uj58rHMc5HotszitSDUkGVon7bAlHeR9Z/oSLurUO6TcFf6dUEy7qvdZ4
         pyo/m15S7AEFMeImMhtg3r8CCiLqlJtFTHp3pbUtyi1VzkLOHzhPWZuodpIqSLfB3s0x
         GJm9JwVB92syE0gsih9IPSse2mRRkcPT93aB7OYhO4PycqcZG3ZqXOvpz9CX+OfMyOyN
         tv7YTSAhAOPWf8WZcx0qLddIsvzmM3Kv/mnpfW50JjcQV/z+VJkba856nHvS2Q9q1/9J
         pLMmLE/xkUXl6nvtQdX8IaIQre4irLR+FQupDx9mM05N+JPJBuCnD/wSr2iwy+9oSFv5
         Wlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781092037; x=1781696837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8FfiefZ2Iv6Y+bSBqRU8RJhOCQtMXaaY/t2xo867vE8=;
        b=c+/cK9VunPYlt++vMXRkNC/bMDrz6BOzmPrbn8+WSbq2T4lY9tT0UAYupNoRIYXpwl
         iTprv2+e/zyLwhx7g8MMwKXGHH2EetBcVniH7U0htBE2xLaz9w5HCCQbMmeKGL+eRcYx
         5uF5OdvSplXjaFhbZ2rh5CMNobqAYQID81HcuWyqvzNIczamXorzKCzeUbCu2NWkm2/W
         y/QydZa5bzrR87E6qirnguCM89LBE83We27dT0xSsBPXBqvHEJHL58wPzT8CGp4w8NYU
         ZdNnwPwR1IS3iJFhF5sz1l9GzeDXpihICq887HrGuJJlw4jbNojBf5CAGaNYBR1+b1XW
         o9oQ==
X-Gm-Message-State: AOJu0Yxw0w+eYTSLont2NtHcjnh1Jt2HMmQnIXci27n8iP2saUS86xGk
	r/bUZQyCYDEYatub3Z/lTfW7qHV5k7xtD+IrM1ef3sZnPxbnhjAQ1IIsgPqgDzDb
X-Gm-Gg: Acq92OFaca9T66VlTzWnYQ3WPfZITFT2zMMja1lBSAYqQ6vyGa3rt7S8of9giZrPAA0
	glytY8im0MAqOmRvPiXyVaKuxB+lbmgDDraObAMCmDGd7CbfRlXS7Y32A5/F8e3iP9OYBLkN3f4
	So0v/gDhOYo2jFkvBrRg3rQYPxPRmEAtevuAMwgw0qBHzLZrJoBN7SINpVlUVlgL/kRw6HQ9j5I
	GmCWTDOWFIUyqhdgWUBlEQlVG6omgFGJxXNxGg2uXL06x4JRCFReED0wPw37CwI4wcfRuTFMpE6
	wSYYgTVCrMUktt8pLJeIklUgQw/Oekuxpi6iTMs1N1LA9m3DzGKcay+MChn3YO2kNm/owEssuh9
	lNFMGnrzATHu0IH+KGbEF+hvs/O/ULZCQ4p28IW3Adwrw/Ci20eIkhGeBkJYEUu2gB3PRLPomZx
	k6Jgj1fOkj0na/UshB3jCL/l+4U+8c
X-Received: by 2002:a05:6402:51c9:b0:68c:eb73:3918 with SMTP id 4fb4d7f45d1cf-68fa4d225c6mr12639915a12.10.1781092036440;
        Wed, 10 Jun 2026 04:47:16 -0700 (PDT)
Received: from ubuntu1.. ([194.87.83.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6912faea64dsm5997164a12.19.2026.06.10.04.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:47:15 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH 6/8] pseudolog.c: Change pseudo_diag() calls to appropriate macros
Date: Wed, 10 Jun 2026 14:46:08 +0300
Message-ID: <20260610114610.60776-6-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610114610.60776-1-frezidok1@gmail.com>
References: <20260610114610.60776-1-frezidok1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jun 2026 11:47:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4197

From: Dmitry Sakhonchik <frezidok1@gmail.com>

Implements [YOCTO #12141]

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
---
 pseudolog.c | 76 ++++++++++++++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/pseudolog.c b/pseudolog.c
index 44f7dbf..a497eb5 100644
--- a/pseudolog.c
+++ b/pseudolog.c
@@ -128,7 +128,7 @@ plog_query_type(char **string) {
 		return PSQT_UNKNOWN;
 	switch (**string) {
 	case '\0':
-		pseudo_diag("Error: Value may not be an empty string.");
+		pseudo_error("Value may not be an empty string.");
 		return PSQT_UNKNOWN;
 		break;
 	case '>':
@@ -170,7 +170,7 @@ plog_query_type(char **string) {
 		break;
 	}
 	if (opt_l && type != PSQT_EXACT) {
-		pseudo_diag("Error: Non-exact match requested while trying to create a log entry.\n");
+		pseudo_error("Non-exact match requested while trying to create a log entry.\n");
 		type = PSQT_UNKNOWN;
 	}
 	return type;
@@ -214,7 +214,7 @@ parse_file_type(char *string) {
 		return S_IFSOCK;
 		break;
 	default:
-		pseudo_diag("unknown file type %c; should be one of [-bcdflps]\n",
+		pseudo_error("unknown file type %c; should be one of [-bcdflps]\n",
 			isprint(*string) ? *string : '?');
 		return -1;
 		break;
@@ -231,7 +231,7 @@ parse_partial_mode(char *string) {
 	case '-':
 		break;
 	default:
-		pseudo_diag("unknown mode character: %c\n", string[0]);
+		pseudo_error("unknown mode character: %c\n", string[0]);
 		return -1;
 		break;
 	}
@@ -242,7 +242,7 @@ parse_partial_mode(char *string) {
 	case '-':
 		break;
 	default:
-		pseudo_diag("unknown mode character: %c\n", string[1]);
+		pseudo_error("unknown mode character: %c\n", string[1]);
 		return -1;
 		break;
 	}
@@ -261,7 +261,7 @@ parse_partial_mode(char *string) {
 	case '-':
 		break;
 	default:
-		pseudo_diag("unknown mode character: %c\n", string[2]);
+		pseudo_error("unknown mode character: %c\n", string[2]);
 		return -1;
 		break;
 	}
@@ -275,14 +275,14 @@ parse_mode_string(char *string) {
 	mode_t bits = 0;
 
 	if (len != 9 && len != 10) {
-		pseudo_diag("mode strings must be of the form [-]rwxr-xr-x\n");
+		pseudo_error("mode strings must be of the form [-]rwxr-xr-x\n");
 		return -1;
 	}
 	if (len == 10) {
 		mode |= parse_file_type(string);
 		++string;
 		if (mode == (mode_t) -1) {
-			pseudo_diag("mode strings with a file type must use a valid type [-bcdflps]\n");
+			pseudo_error("mode strings with a file type must use a valid type [-bcdflps]\n");
 			return -1;
 		}
 	}
@@ -341,14 +341,14 @@ parse_timestamp(char *string) {
 		}
 	}
 	if (!time_formats[i]) {
-		pseudo_diag("Couldn't parse <%s> as a time.  Current time in known formats is:\n",
+		pseudo_error("Couldn't parse <%s> as a time.  Current time in known formats is:\n",
 			string);
 		localtime_r(&stamp_sec, &stamp_tm);
 		for (i = 0; time_formats[i]; ++i) {
 			strftime(timebuf, sizeof(timebuf), time_formats[i], &stamp_tm);
-			pseudo_diag("\t%s\n", timebuf);
+			pseudo_info("\t%s\n", timebuf);
 		}
-		pseudo_diag("Or, specify your own with -E; see strptime(3).\n");
+		pseudo_info("Or, specify your own with -E; see strptime(3).\n");
 		return -1;
 	}
 	return mktime(&stamp_tm);
@@ -360,31 +360,31 @@ plog_trait(int opt, char *string) {
 	char *endptr;
 
 	if (opt < 0 || opt > UCHAR_MAX) {
-		pseudo_diag("Unknown/invalid option value: %d\n", opt);
+		pseudo_error("Unknown/invalid option value: %d\n", opt);
 		return 0;
 	}
 	if (!opt_to_field[opt]) {
 		if (isprint(opt)) {
-			pseudo_diag("Unknown option: -%c\n", opt);
+			pseudo_error("Unknown option: -%c\n", opt);
 		} else {
-			pseudo_diag("Unknown option: 0x%02x\n", opt);
+			pseudo_error("Unknown option: 0x%02x\n", opt);
 		}
 		return 0;
 	}
 	if (!*string) {
-		pseudo_diag("invalid empty string for -%c\n", opt);
+		pseudo_error("invalid empty string for -%c\n", opt);
 		return 0;
 	}
 	new_trait = calloc(1, sizeof(*new_trait));
 	if (!new_trait) {
-		pseudo_diag("Couldn't allocate requested trait (for -%c %s)\n",
+		pseudo_error("Couldn't allocate requested trait (for -%c %s)\n",
 			opt, string ? string : "<nil>");
 		return 0;
 	}
 	new_trait->field = opt_to_field[opt];
 	new_trait->type = plog_query_type(&string);
 	if (new_trait->type == PSQT_UNKNOWN) {
-		pseudo_diag("Couldn't comprehend trait type for '%s'\n",
+		pseudo_error("Couldn't comprehend trait type for '%s'\n",
 			string ? string : "<nil>");
 		free(new_trait);
 		return 0;
@@ -393,7 +393,7 @@ plog_trait(int opt, char *string) {
 	case PSQF_ACCESS:
 		new_trait->data.ivalue = pseudo_access_fopen(string);
 		if (new_trait->data.ivalue == (unsigned long long) -1) {
-			pseudo_diag("access flags should be specified like fopen(3) mode strings (or x for exec).\n");
+			pseudo_error("access flags should be specified like fopen(3) mode strings (or x for exec).\n");
 			free(new_trait);
 			return 0;
 		}
@@ -406,7 +406,7 @@ plog_trait(int opt, char *string) {
 		 * first character is the terminating NUL, we may not
 		 * access the second. */
 		if (string[0] && string[1]) {
-			pseudo_diag("file type must be a single character [-bcdflps].\n");
+			pseudo_error("file type must be a single character [-bcdflps].\n");
 			free(new_trait);
 			return 0;
 		}
@@ -421,13 +421,13 @@ plog_trait(int opt, char *string) {
 		break;
 	case PSQF_ORDER:
 		if (string[0] && string[1]) {
-			pseudo_diag("order type must be a single specifier character.\n");
+			pseudo_error("order type must be a single specifier character.\n");
 			free(new_trait);
 			return 0;
 		}
 		new_trait->data.ivalue = opt_to_field[(unsigned char) string[0]];
 		if (!new_trait->data.ivalue) {
-			pseudo_diag("Unknown field type: %c\n", string[0]);
+			pseudo_error("Unknown field type: %c\n", string[0]);
 		}
 		break;
 	case PSQF_RESULT:
@@ -454,7 +454,7 @@ plog_trait(int opt, char *string) {
 	case PSQF_UID:
 		new_trait->data.ivalue = pseudo_strtoll_wrapper(string, &endptr, 0);
 		if (*endptr) {
-			pseudo_diag("Unexpected garbage after number (%llu): '%s'\n",
+			pseudo_error("Unexpected garbage after number (%llu): '%s'\n",
 				new_trait->data.ivalue, endptr);
 			free(new_trait);
 			return 0;
@@ -485,7 +485,7 @@ plog_trait(int opt, char *string) {
 		new_trait->data.svalue = strdup(string);
 		break;
 	default:
-		pseudo_diag("I don't know how I got here.  Unknown field type %d.\n",
+		pseudo_error("I don't know how I got here.  Unknown field type %d.\n",
 			new_trait->field);
 		free(new_trait);
 		return 0;
@@ -518,7 +518,7 @@ main(int argc, char **argv) {
 		case 'P':
 			s = PSEUDO_ROOT_PATH(AT_FDCWD, optarg, AT_SYMLINK_NOFOLLOW);
 			if (!s)
-				pseudo_diag("Can't resolve prefix path '%s'\n", optarg);
+				pseudo_error("Can't resolve prefix path '%s'\n", optarg);
 			pseudo_set_value("PSEUDO_PREFIX", s);
 			break;
 		case 'v':
@@ -597,12 +597,12 @@ main(int argc, char **argv) {
 	pseudo_debug_flags_finalize();
 
 	if (optind < argc) {
-		pseudo_diag("Error: Extra arguments not associated with any option.\n");
+		pseudo_error("extra arguments not associated with any option.\n");
 		usage(EXIT_FAILURE);
 	}
 
 	if (query_only && opt_l) {
-		pseudo_diag("Error: -l cannot be used with query-only options or flags.\n");
+		pseudo_error("-l cannot be used with query-only options or flags.\n");
 		bad_args = 1;
 	}
 
@@ -611,22 +611,22 @@ main(int argc, char **argv) {
 		exit(EXIT_FAILURE);
 
 	if (!pseudo_get_prefix(argv[0])) {
-		pseudo_diag("Can't figure out prefix.  Set PSEUDO_PREFIX or invoke with full path.\n");
+		pseudo_error("Can't figure out prefix.  Set PSEUDO_PREFIX or invoke with full path.\n");
 		exit(EXIT_FAILURE);
 	}
 
 	if (!pseudo_get_bindir()) {
-		pseudo_diag("Can't figure out bindir.  Set PSEUDO_BINDIR.\n");
+		pseudo_error("Can't figure out bindir.  Set PSEUDO_BINDIR.\n");
 		exit(EXIT_FAILURE);
 	}
 
 	if (!pseudo_get_libdir()) {
-		pseudo_diag("Can't figure out libdir.  Set PSEUDO_LIBDIR.\n");
+		pseudo_error("Can't figure out libdir.  Set PSEUDO_LIBDIR.\n");
 		exit(EXIT_FAILURE);
 	}
 
 	if (!pseudo_get_localstatedir()) {
-		pseudo_diag("Can't figure out localstatedir.  Set PSEUDO_LOCALSTATEDIR.\n");
+		pseudo_error("Can't figure out localstatedir.  Set PSEUDO_LOCALSTATEDIR.\n");
 		exit(EXIT_FAILURE);
 	}
 
@@ -636,12 +636,12 @@ main(int argc, char **argv) {
 		int fields;
 		fields = format_scan(format);
 		if (fields == -1) {
-			pseudo_diag("couldn't parse format string (%s).\n", format);
+			pseudo_error("couldn't parse format string (%s).\n", format);
 			return EXIT_FAILURE;
 		}
 		if (opt_D) {
 			if (pdb_delete(traits, fields)) {
-				pseudo_diag("errors occurred trying to delete entries.\n");
+				pseudo_error("errors occurred trying to delete entries.\n");
 			}
 		} else {
 			history = pdb_history(traits, fields, opt_U);
@@ -653,7 +653,7 @@ main(int argc, char **argv) {
 				}
 				pdb_history_free(history);
 			} else {
-				pseudo_diag("could not retrieve history.\n");
+				pseudo_error("could not retrieve history.\n");
 				return EXIT_FAILURE;
 			}
 		}
@@ -674,12 +674,12 @@ format_one(log_entry *e, char *format) {
 	char *s;
 
 	if (!e || !format) {
-		pseudo_diag("invalid log entry or format specifier.\n");
+		pseudo_error("invalid log entry or format specifier.\n");
 		return 0;
 	}
 	real_len = snprintf(fmtbuf, sizeof(fmtbuf), "%.*s", (int) len + 1, format);
 	if (real_len >= sizeof(fmtbuf) - 1) {
-		pseudo_diag("Format string way too long starting at %.10s",
+		pseudo_error("Format string way too long starting at %.10s",
 			format - 1);
 		return 0;
 	}
@@ -690,7 +690,7 @@ format_one(log_entry *e, char *format) {
 	 * parameters -- this doesn't make sense here.
 	 */
 	if (strchr(fmtbuf, '*') || strchr(fmtbuf, 'l') || strchr(fmtbuf, 'h')) {
-		pseudo_diag("Sorry, you can't use *, h, or l format modifiers.\n");
+		pseudo_error("Sorry, you can't use *, h, or l format modifiers.\n");
 		return 0;
 	}
 
@@ -830,7 +830,7 @@ format_scan(char *format) {
 		len = strcspn(s, "acdfgGimMoprRsStTuy");
 		s += len;
 		if (!*s) {
-			pseudo_diag("Unknown format: '%.3s'\n",
+			pseudo_error("Unknown format: '%.3s'\n",
 				(s - len));
 			return -1;
 		}
@@ -865,7 +865,7 @@ format_scan(char *format) {
 			 */
 			break;
 		default:
-			pseudo_diag("error: invalid format specifier %c (at %s)\n", *s, s);
+			pseudo_error("invalid format specifier %c (at %s)\n", *s, s);
 			return -1;
 			break;
 		}

