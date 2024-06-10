Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FB1C41513
	for <webhook@archiver.kernel.org>; Mon, 10 Jun 2024 14:33:01 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.web11.21016.1718029973778071980
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Jun 2024 07:32:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=HwoMR2xp;
 spf=pass (domain: snapchat.com, ip: 209.85.208.53, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57c6011d75dso3154124a12.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Jun 2024 07:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1718029972; x=1718634772; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yt53I7BD/Wer5berYLwfLC1jYI1WIw1L+4bTlgiSjMc=;
        b=HwoMR2xpCoI4MzkHsq4cJe90CHzE1ZGYp/29ZxHB0kFig584ST62ceJcIYIpcn167U
         neTeK51YIrCk9SmosYzUpL5YxWoiyIZEMCnqCtMfViRAqU/QuDT9QBt2pbZlTKFLhUrO
         kLMt7S9Ez32QTStMr1Em1ROXj0ocPpPatVZ80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718029972; x=1718634772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yt53I7BD/Wer5berYLwfLC1jYI1WIw1L+4bTlgiSjMc=;
        b=HQiPfjmqAlIjloxe+xrmbQ+xzhbBSIPjBfmzKzkIWEvOVRyyEig47nBmY8aiMGJ9Yp
         vKhKWtaY+tHOYNqwTmzqSbsmYWqtSXmYdpJHRwi5ElCd4mGgdW7afk8JOGZH0thLcOb9
         +630rj5n229v1FNLQMi3FPTsXVqtkxCWdQHHMzFQXJoE80n7ELISpSkRT06b1vIfXkD7
         zN2CtnVynDwv7SURmnJldyEewcKg6oVMlGkQpj8C0XzhknLeP9wPi1PA74bFaMsrL9wL
         wAiBaakQu4wF8mRzaSCiLqgvQLt2qBNKGZnHAbbBx28dlcVdVSZN/ZO+AN2GIVnLc68N
         GhDA==
X-Gm-Message-State: AOJu0Yx7itnCrPBT3cMqJjxqfTvwdU0UGo+/ZS9lrPtDQ9cuVBZwDqms
	X95PIZLlO7RV2HKOympMIxGU7vGQVMWpOAntNnqxurnnDop4xJ2MX296Rj5N11yBIxCuakzKdhh
	/Vvw=
X-Google-Smtp-Source: AGHT+IHiaCFAWDVeJUH/2VFT5BROOKRJwAYw2u7zkBQxq9ABjd+VmdDLZc+0eYNJlv9sSMEP5hrRbQ==
X-Received: by 2002:a50:9f4b:0:b0:57c:6004:438a with SMTP id 4fb4d7f45d1cf-57c60044668mr5419155a12.34.1718029971655;
        Mon, 10 Jun 2024 07:32:51 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae237408sm7504233a12.93.2024.06.10.07.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 07:32:51 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 06/11] binutils: update to scarthgap (disable libctf)
Date: Mon, 10 Jun 2024 16:32:09 +0200
Message-Id: <20240610143214.2376414-6-ecordonnier@snap.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
In-Reply-To: <20240610143214.2376414-1-ecordonnier@snap.com>
References: <20240610143214.2376414-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Jun 2024 14:33:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/288

From: Etienne Cordonnier <ecordonnier@snap.com>

libctf does not compile with scarthgap. Let's disable it (I don't think anybody is using it with meta-darwin).

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 .../0001-OS-1142-Do-not-use-nm-B-for-Darwin-s-nm.patch | 10 +++++-----
 recipes-devtools/binutils/binutils_%.bbappend          |  3 +++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/recipes-devtools/binutils/binutils/0001-OS-1142-Do-not-use-nm-B-for-Darwin-s-nm.patch b/recipes-devtools/binutils/binutils/0001-OS-1142-Do-not-use-nm-B-for-Darwin-s-nm.patch
index 6d28872..bc7336c 100644
--- a/recipes-devtools/binutils/binutils/0001-OS-1142-Do-not-use-nm-B-for-Darwin-s-nm.patch
+++ b/recipes-devtools/binutils/binutils/0001-OS-1142-Do-not-use-nm-B-for-Darwin-s-nm.patch
@@ -21,26 +21,26 @@ Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
  2 files changed, 2 insertions(+), 2 deletions(-)
 
 diff --git a/libbacktrace/configure b/libbacktrace/configure
-index 90667680701..dec8d96771b 100755
+index 406b67b8cbc..8a51b1ee0da 100755
 --- a/libbacktrace/configure
 +++ b/libbacktrace/configure
 @@ -5846,7 +5846,7 @@ else
         # Adding the `sed 1q' prevents false positives on HP-UX, which says:
         #   nm: unknown option "B" ignored
-        case `"$tmp_nm" -B "$tmp_nm" 2>&1 | grep -v '^ *$' | sed '1q'` in
+        case `"$tmp_nm" -B "$tmp_nm_to_nm" 2>&1 | grep -v '^ *$' | sed '1q'` in
 -       *$tmp_nm*) lt_cv_path_NM="$tmp_nm -B"
 +       *$tmp_nm*) lt_cv_path_NM="$tmp_nm"
  	 break
  	 ;;
         *)
 diff --git a/libctf/configure b/libctf/configure
-index 1b0ee0d32c6..f77ae01e21a 100755
+index a0e40f49a80..00fba29d253 100755
 --- a/libctf/configure
 +++ b/libctf/configure
-@@ -5982,7 +5982,7 @@ else
+@@ -5967,7 +5967,7 @@ else
         # Adding the `sed 1q' prevents false positives on HP-UX, which says:
         #   nm: unknown option "B" ignored
-        case `"$tmp_nm" -B "$tmp_nm" 2>&1 | grep -v '^ *$' | sed '1q'` in
+        case `"$tmp_nm" -B "$tmp_nm_to_nm" 2>&1 | grep -v '^ *$' | sed '1q'` in
 -       *$tmp_nm*) lt_cv_path_NM="$tmp_nm -B"
 +       *$tmp_nm*) lt_cv_path_NM="$tmp_nm"
  	 break
diff --git a/recipes-devtools/binutils/binutils_%.bbappend b/recipes-devtools/binutils/binutils_%.bbappend
index d6827ab..03e4ceb 100644
--- a/recipes-devtools/binutils/binutils_%.bbappend
+++ b/recipes-devtools/binutils/binutils_%.bbappend
@@ -12,3 +12,6 @@ FILES:${PN} += " \
 # TODO: Needs to be fixed by packaging this right
 # We should filter .debug out to the dbg package
 INSANE_SKIP:nativesdk-binutils = "debug-files"
+
+# nativesdk-binutils's libctf doesn't compile. disable it
+PACKAGECONFIG[libctf] = "--enable-libctf=yes,--enable-libctf=no"
-- 
2.36.1.vfs.0.0


