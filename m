Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0F5D2ECF1
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 20:40:23 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44338.1768855220163504155
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Jan 2026 12:40:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=SEvDrqcd;
 spf=pass (domain: konsulko.com, ip: 209.85.222.169, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c530866cf0so459487085a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 12:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768855219; x=1769460019; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8bq+6KeqQyN23rui25FW9ufE+GtUa1ry7e/bdMMZBc=;
        b=SEvDrqcdxxJgkFoja2yPu0HQREoc1z2VZaQqt36Wuk4M1xjAbjjk5rFJczKp4G07N3
         5iUWDv6Vn+HL6b0Vi553xi6QXx6HPFKtOaULergGT+sIF8rLqLbraL1joi46p5MXxyyv
         /i65s5QNWj27rnTFkzgvhFNgsPqTJxviut7SY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768855219; x=1769460019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M8bq+6KeqQyN23rui25FW9ufE+GtUa1ry7e/bdMMZBc=;
        b=PODhHJl4sXpn69It06npfdl7+3t0+T2xd1qkzuVIS/sJzDXjYMcGj3aXR92ZkTMA/J
         4k8vVKpKETOyTwGYwCz/cpUlm0kKZNf65c+aVRy9FSQU1qxgQdwElkbTm8msVfoCRzPG
         SgTDhOacaWCoZpc3MlLjeLG2zTOPtaenkDkY694rnJVe4Bo+bNGVN43DKQqH4fh+/hoH
         J0u4z162d1bRqJONxlZdZz6nrSHFoYk8krcdnymDVBx7FehekxAvl+jV00S8fTGXu/YW
         Q48bOac4OgmrlC+c6uxPdiI56ZzOI1te4MKoI22nujpWkVODCjgMVlfQRHp4m5LSpZ0y
         vnmw==
X-Gm-Message-State: AOJu0YwjW6E4UStHhMW8Hh1+qy4Ao0s9zvt+yGAzHPU1+hAlWLYLXEOd
	B7RD3OGl3NAQv43PpqAG4zk9DQc9sFpXecsknOv70cE7cnvfGwNbF0eI4CMDMp4CfEyVNb5WGkR
	NFNMo
X-Gm-Gg: AY/fxX5lXfMJziU8pmM7AaVIgfvQjtUqvW08C8V99Ocx7jto5XUDdEWT6yTxJrTYU7N
	bY9mrHJ6DpqdbkGTD/09knNkjzYNEniFZSJpzZuBHBJOvgC69427xAtklr18xo/gLKEwA2H0o7n
	K4hBXWp/kjAg28HTqcwkH+i1bhpGAKTtOomvssVyqaalIeq4g9bmgYElVvP+SVv65ZvGcr/86DE
	miLNbTiI78xS6kuTpnq2pX7w7LYOjSVE95M48PEIE/K4oJjxYfjNXxUP29GgDPe2chojkZL3msx
	r5Qop44XtDrkO+EsF1Ltu0l79yA7rHISvthzJ6bPm9+JCQYw5x9j0GPvYLIASXcCtAg9OTP/Fwo
	9fvBrSSL6tDUjllwdkrQ4CCTLYLQVcx24P5NNdyE4fcKSYC8xOLKZmcPEG/EXPnrV3tKjDIiP3G
	jIQJ/JflSacYJM5eYhTpt0vbRsXD/46GtH2iUj9lT2Iq0gD+nB3I42DQ0DYXb0pr1qimOzXD8Jq
	Rpv95ng9lkANNVq17n4lZGMaiFaK1AoaM36R4OndTzExDCG2rKl
X-Received: by 2002:a05:620a:7003:b0:8c6:ad72:7a5c with SMTP id af79cd13be357-8c6ad727cf4mr1354731685a.23.1768855218788;
        Mon, 19 Jan 2026 12:40:18 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a70f1fe1sm851462085a.0.2026.01.19.12.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:40:18 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-security][scarthgap][PATCH 3/6] sssd: Upgrade to 2.9.7
Date: Mon, 19 Jan 2026 15:39:58 -0500
Message-ID: <62059c7e36c4a91c0f9579f986c24140a1260ed1.1768854779.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768854779.git.scott.murray@konsulko.com>
References: <cover.1768854779.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 20:40:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3027

Release notes:
https://sssd.io/release-notes/sssd-2.9.6.html
https://sssd.io/release-notes/sssd-2.9.7.html

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../0001-sssctl-add-error-analyzer.patch      | 42 ++++++++++---------
 .../sssd/files/CVE-2025-11561.patch           |  6 +--
 .../sssd/files/drop_ntpdate_chk.patch         | 17 +++++---
 .../sssd/files/fix-ldblibdir.patch            |  9 +++-
 .../recipes-security/sssd/files/fix_gid.patch | 16 +++++--
 .../sssd/files/musl_fixup.patch               | 34 ++++++++-------
 .../recipes-security/sssd/files/no_gen.patch  | 18 +++++---
 .../sssd/{sssd_2.9.5.bb => sssd_2.9.7.bb}     |  2 +-
 8 files changed, 90 insertions(+), 54 deletions(-)
 rename dynamic-layers/networking-layer/recipes-security/sssd/{sssd_2.9.5.bb => sssd_2.9.7.bb} (98%)

diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/files/0001-sssctl-add-error-analyzer.patch b/dynamic-layers/networking-layer/recipes-security/sssd/files/0001-sssctl-add-error-analyzer.patch
index 6880405..4f58125 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/files/0001-sssctl-add-error-analyzer.patch
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/files/0001-sssctl-add-error-analyzer.patch
@@ -1,13 +1,17 @@
+From 56bcfecda72dc56c1bb8b8eb2721033f54dba9f8 Mon Sep 17 00:00:00 2001
+From: roy214 <abroy@redhat.com>
+Date: Tue, 25 Apr 2023 20:01:24 +0530
+Subject: [PATCH] sssctl: add error analyzer
+MIME-Version: 1.0
+Content-Type: text/plain; charset=UTF-8
+Content-Transfer-Encoding: 8bit
+
 Backport patch to fix interpreter of sss_analyze.
 
 Upstream-Status: Backport [https://github.com/SSSD/sssd/commit/ed3726c]
 
 Signed-off-by: Kai Kang <kai.kang@windriver.com>
 
-From ed3726c37fe07aab788404bfa2f9003db15f4210 Mon Sep 17 00:00:00 2001
-From: roy214 <abroy@redhat.com>
-Date: Tue, 25 Apr 2023 20:01:24 +0530
-Subject: [PATCH] sssctl: add error analyzer
 MIME-Version: 1.0
 Content-Type: text/plain; charset=UTF-8
 Content-Transfer-Encoding: 8bit
@@ -28,7 +32,7 @@ Reviewed-by: Tomáš Halman <thalman@redhat.com>
  create mode 100644 src/tools/analyzer/util.py
 
 diff --git a/src/tools/analyzer/Makefile.am b/src/tools/analyzer/Makefile.am
-index b40043d043..7692af8528 100644
+index b40043d..7692af8 100644
 --- a/src/tools/analyzer/Makefile.am
 +++ b/src/tools/analyzer/Makefile.am
 @@ -13,10 +13,12 @@ dist_pkgpython_DATA = \
@@ -46,7 +50,7 @@ index b40043d043..7692af8528 100644
      $(NULL)
 diff --git a/src/tools/analyzer/modules/error.py b/src/tools/analyzer/modules/error.py
 new file mode 100644
-index 0000000000..71173670c5
+index 0000000..7117367
 --- /dev/null
 +++ b/src/tools/analyzer/modules/error.py
 @@ -0,0 +1,61 @@
@@ -112,7 +116,7 @@ index 0000000000..71173670c5
 +            print("For possible solutions please refer to https://sssd.io/troubleshooting/errors.html")
 +        return
 diff --git a/src/tools/analyzer/modules/request.py b/src/tools/analyzer/modules/request.py
-index d661dddb84..e4d5f060c7 100644
+index d661ddd..e4d5f06 100644
 --- a/src/tools/analyzer/modules/request.py
 +++ b/src/tools/analyzer/modules/request.py
 @@ -1,6 +1,6 @@
@@ -123,7 +127,7 @@ index d661dddb84..e4d5f060c7 100644
  from sssd.parser import SubparsersAction
  from sssd.parser import Option
  
-@@ -38,7 +38,6 @@ def print_module_help(self, args):
+@@ -38,7 +38,6 @@ class RequestAnalyzer:
      def setup_args(self, parser_grp, cli):
          """
          Setup module parser, subcommands, and options
@@ -131,7 +135,7 @@ index d661dddb84..e4d5f060c7 100644
          Args:
              parser_grp (argparse.Action): Parser group to nest
                 module and subcommands under
-@@ -63,42 +62,6 @@ def setup_args(self, parser_grp, cli):
+@@ -63,42 +62,6 @@ class RequestAnalyzer:
  
          return self.module_parser
  
@@ -174,7 +178,7 @@ index d661dddb84..e4d5f060c7 100644
      def get_linked_ids(self, source, pattern, regex):
          """
          Retrieve list of associated REQ_TRACE ids. Filter
-@@ -114,8 +77,9 @@ def get_linked_ids(self, source, pattern, regex):
+@@ -114,8 +77,9 @@ class RequestAnalyzer:
          Returns:
              List of linked ids discovered
          """
@@ -185,7 +189,7 @@ index d661dddb84..e4d5f060c7 100644
              id_re = re.compile(regex)
              match = id_re.search(match)
              if match:
-@@ -250,7 +214,8 @@ def list_requests(self, args):
+@@ -250,7 +214,8 @@ class RequestAnalyzer:
          Args:
              args (Namespace):  populated argparse namespace
          """
@@ -195,7 +199,7 @@ index d661dddb84..e4d5f060c7 100644
          component = source.Component.NSS
          resp = "nss"
          # Log messages matching the following regex patterns contain
-@@ -266,7 +231,7 @@ def list_requests(self, args):
+@@ -266,7 +231,7 @@ class RequestAnalyzer:
          if args.verbose:
              self.print_formatted_verbose(source)
          else:
@@ -204,7 +208,7 @@ index d661dddb84..e4d5f060c7 100644
                  if type(source).__name__ == 'Journald':
                      print(line)
                  else:
-@@ -279,7 +244,8 @@ def track_request(self, args):
+@@ -279,7 +244,8 @@ class RequestAnalyzer:
          Args:
              args (Namespace):  populated argparse namespace
          """
@@ -214,7 +218,7 @@ index d661dddb84..e4d5f060c7 100644
          cid = args.cid
          resp_results = False
          be_results = False
-@@ -294,7 +260,7 @@ def track_request(self, args):
+@@ -294,7 +260,7 @@ class RequestAnalyzer:
          logger.info(f"******** Checking {resp} responder for Client ID"
                      f" {cid} *******")
          source.set_component(component, args.child)
@@ -223,7 +227,7 @@ index d661dddb84..e4d5f060c7 100644
              resp_results = self.consume_line(match, source, args.merge)
  
          logger.info(f"********* Checking Backend for Client ID {cid} ********")
-@@ -307,7 +273,7 @@ def track_request(self, args):
+@@ -307,7 +273,7 @@ class RequestAnalyzer:
          pattern.clear()
          [pattern.append(f'\\{id}') for id in be_ids]
  
@@ -233,7 +237,7 @@ index d661dddb84..e4d5f060c7 100644
  
          if args.merge:
 diff --git a/src/tools/analyzer/sss_analyze b/src/tools/analyzer/sss_analyze
-index 3f1beaf38b..6d4b5b30c6 100755
+index 3f1beaf..6d4b5b3 100755
 --- a/src/tools/analyzer/sss_analyze
 +++ b/src/tools/analyzer/sss_analyze
 @@ -1,4 +1,4 @@
@@ -243,7 +247,7 @@ index 3f1beaf38b..6d4b5b30c6 100755
  from sssd import sss_analyze
  
 diff --git a/src/tools/analyzer/sss_analyze.py b/src/tools/analyzer/sss_analyze.py
-index 18b998f380..dafc84fc03 100644
+index 18b998f..dafc84f 100644
 --- a/src/tools/analyzer/sss_analyze.py
 +++ b/src/tools/analyzer/sss_analyze.py
 @@ -1,6 +1,7 @@
@@ -254,7 +258,7 @@ index 18b998f380..dafc84fc03 100644
  from sssd.parser import SubparsersAction
  
  
-@@ -55,9 +56,11 @@ def load_modules(self, parser, parser_grp):
+@@ -55,9 +56,11 @@ class Analyzer:
          """
          # Currently only the 'request' module exists
          req = request.RequestAnalyzer()
@@ -268,7 +272,7 @@ index 18b998f380..dafc84fc03 100644
          """
 diff --git a/src/tools/analyzer/util.py b/src/tools/analyzer/util.py
 new file mode 100644
-index 0000000000..2a8d153a71
+index 0000000..2a8d153
 --- /dev/null
 +++ b/src/tools/analyzer/util.py
 @@ -0,0 +1,44 @@
diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/files/CVE-2025-11561.patch b/dynamic-layers/networking-layer/recipes-security/sssd/files/CVE-2025-11561.patch
index 8111ca0..110444a 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/files/CVE-2025-11561.patch
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/files/CVE-2025-11561.patch
@@ -1,4 +1,4 @@
-From e5224f0cb684e61203d2cd8045266f7248696204 Mon Sep 17 00:00:00 2001
+From 9fdc7f2b4ed50a5ce788a86f2a5be448668381f5 Mon Sep 17 00:00:00 2001
 From: Sumit Bose <sbose@redhat.com>
 Date: Fri, 10 Oct 2025 12:57:40 +0200
 Subject: [PATCH] krb5: disable Kerberos localauth an2ln plugin for AD/IPA
@@ -37,10 +37,10 @@ Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/src/util/domain_info_utils.c b/src/util/domain_info_utils.c
-index edaf967e186..5c1f050184e 100644
+index edaf967..5c1f050 100644
 --- a/src/util/domain_info_utils.c
 +++ b/src/util/domain_info_utils.c
-@@ -751,6 +751,7 @@ static errno_t sss_write_krb5_snippet_common(const char *file_name,
+@@ -751,6 +751,7 @@ done:
  #define LOCALAUTH_PLUGIN_CONFIG \
  "[plugins]\n" \
  " localauth = {\n" \
diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/files/drop_ntpdate_chk.patch b/dynamic-layers/networking-layer/recipes-security/sssd/files/drop_ntpdate_chk.patch
index 338af5d..e86a720 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/files/drop_ntpdate_chk.patch
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/files/drop_ntpdate_chk.patch
@@ -1,14 +1,21 @@
+From 1e8e2a324bfdeb2443c78db1689fe526fd5d8b60 Mon Sep 17 00:00:00 2001
+From: Armin Kuster <akuster808@gmail.com>
+Date: Tue, 18 May 2021 15:10:53 +0000
+Subject: [PATCH] sssd: update to 2.5.0
+
 nsupdate path is needed for various exec call
 but don't run natvie tests on it.
 
-
 Upstream-Status: Inappropriate [OE specific]
 Signed-off-by: Armin Kuster <akuster808@gmail.com>
+---
+ src/external/nsupdate.m4 | 12 ------------
+ 1 file changed, 12 deletions(-)
 
-Index: sssd-2.5.0/src/external/nsupdate.m4
-===================================================================
---- sssd-2.5.0.orig/src/external/nsupdate.m4
-+++ sssd-2.5.0/src/external/nsupdate.m4
+diff --git a/src/external/nsupdate.m4 b/src/external/nsupdate.m4
+index a137f38..ab08f57 100644
+--- a/src/external/nsupdate.m4
++++ b/src/external/nsupdate.m4
 @@ -3,16 +3,4 @@ AC_MSG_CHECKING(for executable nsupdate)
  if test -x "$NSUPDATE"; then
    AC_DEFINE_UNQUOTED([NSUPDATE_PATH], ["$NSUPDATE"], [The path to nsupdate])
diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/files/fix-ldblibdir.patch b/dynamic-layers/networking-layer/recipes-security/sssd/files/fix-ldblibdir.patch
index e350baf..f482716 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/files/fix-ldblibdir.patch
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/files/fix-ldblibdir.patch
@@ -1,3 +1,8 @@
+From 512e46f3b9965cff200aa47879857d198afd8fe2 Mon Sep 17 00:00:00 2001
+From: Kai Kang <kai.kang@windriver.com>
+Date: Wed, 16 Jun 2021 14:42:33 +0800
+Subject: [PATCH] sssd: fix for ldblibdir and systemd etc
+
 When calculate value of ldblibdir, it checks whether the directory of
 $ldblibdir exists. If not, it assigns ldblibdir with ${libdir}/ldb. It is not
 suitable for cross compile. Fix it that only re-assign ldblibdir when its value
@@ -11,10 +16,10 @@ Signed-off-by: Kai Kang <kai.kang@windriver.com>
  1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/src/external/libldb.m4 b/src/external/libldb.m4
-index c400add..5e5f06d 100644
+index e8285a9..e98913c 100644
 --- a/src/external/libldb.m4
 +++ b/src/external/libldb.m4
-@@ -19,7 +19,7 @@ if test x"$with_ldb_lib_dir" != x; then
+@@ -22,7 +22,7 @@ if test x"$with_ldb_lib_dir" != x; then
      ldblibdir=$with_ldb_lib_dir
  else
      ldblibdir="`$PKG_CONFIG --variable=modulesdir ldb`"
diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/files/fix_gid.patch b/dynamic-layers/networking-layer/recipes-security/sssd/files/fix_gid.patch
index 419b83f..642002f 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/files/fix_gid.patch
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/files/fix_gid.patch
@@ -1,3 +1,8 @@
+From cf9fd2126e697b02e1561501a20dfa13fee16505 Mon Sep 17 00:00:00 2001
+From: Armin Kuster <akuster808@gmail.com>
+Date: Tue, 18 May 2021 15:10:53 +0000
+Subject: [PATCH] sssd: update to 2.5.0
+
 from ../sssd-2.5.0/src/util/sss_pam_data.c:27:
 | ../sssd-2.5.0/src/util/debug.h:88:44: error: unknown type name 'uid_t'; did you mean 'uint_t'?
 |    88 | int chown_debug_file(const char *filename, uid_t uid, gid_t gid);
@@ -11,11 +16,14 @@ from ../sssd-2.5.0/src/util/sss_pam_data.c:27:
 
 Upstream-Status: Pending
 Signed-off-by: Armin Kuster <akuster808@gmail.com>
+---
+ src/util/debug.h | 2 ++
+ 1 file changed, 2 insertions(+)
 
-Index: sssd-2.7.1/src/util/debug.h
-===================================================================
---- sssd-2.7.1.orig/src/util/debug.h
-+++ sssd-2.7.1/src/util/debug.h
+diff --git a/src/util/debug.h b/src/util/debug.h
+index c33c14e..405c21d 100644
+--- a/src/util/debug.h
++++ b/src/util/debug.h
 @@ -24,6 +24,8 @@
  #include "config.h"
  
diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/files/musl_fixup.patch b/dynamic-layers/networking-layer/recipes-security/sssd/files/musl_fixup.patch
index 68f267c..f998005 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/files/musl_fixup.patch
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/files/musl_fixup.patch
@@ -1,4 +1,7 @@
-fix musl build failures
+From abb66c871d5571accff49a281730246a057b4967 Mon Sep 17 00:00:00 2001
+From: Armin Kuster <akuster808@gmail.com>
+Date: Sun, 4 Jul 2021 08:50:06 -0700
+Subject: [PATCH] fix musl build failures
 
 Missing _PATH_HOSTS and some NETDB defines when musl is enabled.
 
@@ -8,22 +11,25 @@ These are work arounds for now while we figure out where the real fix should res
 |  1199 |                   _PATH_HOSTS);
 |       |                   ^~~~~~~~~~~
 
-and 
+and
 
 i./sssd-2.5.1/src/sss_client/nss_ipnetworks.c:415:21: error: 'NETDB_INTERNAL' undeclared (first use in this function)
 |   415 |         *h_errnop = NETDB_INTERNAL;
 
-
 Upstream-Status: Pending
 Signed-off-by: Armin Kuster <akuster808@gmail.com>
-
-Index: sssd-2.5.1/src/providers/fail_over.c
-===================================================================
---- sssd-2.5.1.orig/src/providers/fail_over.c
-+++ sssd-2.5.1/src/providers/fail_over.c
-@@ -31,6 +31,10 @@
- #include <talloc.h>
+---
+ src/providers/fail_over.c | 4 ++++
+ src/sss_client/sss_cli.h  | 8 ++++++++
+ 2 files changed, 12 insertions(+)
+
+diff --git a/src/providers/fail_over.c b/src/providers/fail_over.c
+index 835ac52..dea4fab 100644
+--- a/src/providers/fail_over.c
++++ b/src/providers/fail_over.c
+@@ -33,6 +33,10 @@
  #include <netdb.h>
+ #include <arpa/inet.h>
  
 +#if !defined(_PATH_HOSTS)
 +#define _PATH_HOSTS     "/etc/hosts"
@@ -32,10 +38,10 @@ Index: sssd-2.5.1/src/providers/fail_over.c
  #include "util/dlinklist.h"
  #include "util/refcount.h"
  #include "util/util.h"
-Index: sssd-2.5.1/src/sss_client/sss_cli.h
-===================================================================
---- sssd-2.5.1.orig/src/sss_client/sss_cli.h
-+++ sssd-2.5.1/src/sss_client/sss_cli.h
+diff --git a/src/sss_client/sss_cli.h b/src/sss_client/sss_cli.h
+index 29b496e..c47e776 100644
+--- a/src/sss_client/sss_cli.h
++++ b/src/sss_client/sss_cli.h
 @@ -44,6 +44,14 @@ typedef int errno_t;
  #define EOK 0
  #endif
diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/files/no_gen.patch b/dynamic-layers/networking-layer/recipes-security/sssd/files/no_gen.patch
index 7d8e80b..0a1972e 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/files/no_gen.patch
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/files/no_gen.patch
@@ -1,14 +1,20 @@
-don't run generate-sbus-code
+From 81074928bf6bf339628eb6427c44f8ad4512a431 Mon Sep 17 00:00:00 2001
+From: Armin Kuster <akuster808@gmail.com>
+Date: Tue, 18 May 2021 15:10:53 +0000
+Subject: [PATCH] don't run generate-sbus-code
 
 Upstream-Status: Inappropriate [OE Specific]
 
 Signed-off-by: Armin Kuster <akuster808@gmail.com>
+---
+ Makefile.am | 2 --
+ 1 file changed, 2 deletions(-)
 
-Index: sssd-2.7.1/Makefile.am
-===================================================================
---- sssd-2.7.1.orig/Makefile.am
-+++ sssd-2.7.1/Makefile.am
-@@ -1023,8 +1023,6 @@ generate-sbus-code:
+diff --git a/Makefile.am b/Makefile.am
+index 3477aa0..8943e8a 100644
+--- a/Makefile.am
++++ b/Makefile.am
+@@ -1036,8 +1036,6 @@ generate-sbus-code:
  
  .PHONY: generate-sbus-code
  
diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.5.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.7.bb
similarity index 98%
rename from dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.5.bb
rename to dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.7.bb
index 2954257..f92fe65 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.5.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.7.bb
@@ -27,7 +27,7 @@ SRC_URI = "https://github.com/SSSD/sssd/releases/download/${PV}/${BP}.tar.gz \
            file://0001-sssctl-add-error-analyzer.patch \
            file://CVE-2025-11561.patch \
            "
-SRC_URI[sha256sum] = "bf955cc26b6d215bbb9083eadb613f78d7b727fb023f39987aec37680ae40ae3"
+SRC_URI[sha256sum] = "6b5284a4d72b67c0897699794360d79e0f67461957e20273c2649f025e76c248"
 
 UPSTREAM_CHECK_URI = "https://github.com/SSSD/${BPN}/releases"
 
-- 
2.51.0


