Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FA0F88092
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 07:07:54 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7879.1776323269744908594
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Apr 2026 00:07:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=wIsHS34u;
 spf=pass (domain: smile.fr, ip: 209.85.221.44, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43eb012ac4fso530979f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Apr 2026 00:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1776323268; x=1776928068; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4I7X2i1k+CinDx6BNWT27EQGqZ530ShbDbUQ0OhmJ6M=;
        b=wIsHS34uXk3vs2RPTap/UCSZvREpAZMb0/svOKkkyVzd6EvDBuxTnkf6LeFFmmJpOI
         VBT21zQ8Yz9Z5GKtcyW/3Tz50YcqLTosgEJ9OHaWp08FyRw3gQCy6G0dMu6DuhjqwG0t
         nkCESExVEUle8fWW42qlaYdBXjYkCk2TSBpos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776323268; x=1776928068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4I7X2i1k+CinDx6BNWT27EQGqZ530ShbDbUQ0OhmJ6M=;
        b=iTFKEjN7dHI0RcRTt2hQRbAgKd+16ghztwOsPRcnwCDCIhiIg44Hde+6TPc+33oMru
         JVM3ez75tyEmuFSkPaGyKm+T9GtGrOoXkagkvZc1wwq1C1f+of7cmhkSxUCVxNy8pKYN
         mnuLO3CoMEwA5Jc04hqkxdfF14G1lGVsBewYv9BjxaNQmjJIa3NHNZjPvIqLycvGPVBU
         9DI4i9gAyfeOzKbyuUnEbp+JpWeJvj/tS6lMEMbHySb3EuXAtT8quaDLa0X3QaPO13ua
         WVS575dcyqjx7OeHtOVlYhmOWQFj6C9Uf+jcsYtDgZusn+dGgbmk+Bj2jNRoBnYflSam
         LxVw==
X-Gm-Message-State: AOJu0YwYThRiuRBxGbXLNM1XaGqMyvftOBmbfpsqqahsuc7U+rw5dILd
	7ypSPU48QUJijW7926bm3QIxNBlDG2ZnAy55pn74eM2S3FqiLQ5r7najOsLld8yfo/nY24CHWXK
	y82GV3seHaw==
X-Gm-Gg: AeBDiesl+IfD5aUsHHobVyArWNUdQTTM7oOKXqvaOxUSwZ1azY4pOGipVFjXmkvM5wC
	XRCAM3ogBolioPxYBsneJstEoapogtqjU6EztFiwIFT6pbPEWCK3zumLDuSs6CH9jKTMG1WNUQ7
	u92Y83JA0eKT/TM7vRsYygf+XegpmuWHfbyzX2LuHgO4UXM3Xt6ZFIflbWfBYJIorutmoU238qM
	rErA81bqu8kFOnyfwPMCt6ehCXlfCuQnhCiInu3b4pOOk4CTIJVpUbBIhoLSBkcq3V8adtkI7CG
	1L7zhMRf4tt+7oMNCSNJMGz/fJkUxvtlLNpYT1bulQ3o+mdCKoqw4B5WyBdK6nkthhFWJQ/j2pi
	KTP286MOsMAQ6wkGp89ArxX7tnhlzWuzd6MkcC4kMeSfOdBR9iU3q0yy93fw1AGoBoaUOCAS6gP
	F/8IbTwl/Q5nNveQ+OMFj98JaGsFY1Hq/jV+e0TQYbN4GxAiZY4sEq+3/quXoj6TE76YVwkEd8L
	C3XXD+PGqGxoiy4Vlqjot6i8NVHucwXhGI8Yg==
X-Received: by 2002:a05:600c:4f56:b0:480:690e:f14a with SMTP id 5b1f17b1804b1-488d68765fcmr366877495e9.14.1776323267771;
        Thu, 16 Apr 2026 00:07:47 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5f06sm11602449f8f.17.2026.04.16.00.07.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 00:07:47 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][whinlatter 5/5]  scripts/yocto-supported-distros: fix the centos stream regular expression
Date: Thu, 16 Apr 2026 09:07:40 +0200
Message-ID: <93894832c9a4ce0b96d16e503bed99a959f3d232.1776323183.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1776323183.git.yoann.congal@smile.fr>
References: <cover.1776323183.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Apr 2026 07:07:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3721

From: Antonin Godard <antonin.godard@bootlin.com>

The poky.conf file was wrongly referring these distros with
centosstream-*, but this is now fixed. Change the regular expression for CentOS
Stream to match this. Remove the CentOS (no Stream) definition as we do not
support it anymore and it conflicts with this one.

Cc: Yoann Congal <yoann.congal@smile.fr>
Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 scripts/yocto-supported-distros | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/scripts/yocto-supported-distros b/scripts/yocto-supported-distros
index 11b05b7..f01a401 100755
--- a/scripts/yocto-supported-distros
+++ b/scripts/yocto-supported-distros
@@ -77,13 +77,9 @@ INPUT_REGEXES = {
         "ab": re.compile(r"^opensuse(\d{2})(\d{1})"),
         "lsb": re.compile(r"^opensuse-(\d{2})\.(\d{1})"),
     },
-    "centos": {
-        "ab": re.compile(r"^centos(\d+)"),
-        "lsb": re.compile(r"^centos-(\d+)"),
-    },
     "centosstream": {
         "ab": re.compile(r"^stream(\d+)"),
-        "lsb": re.compile(r"^stream-(\d+)"),
+        "lsb": re.compile(r"^centos-(\d+)"),
     },
     "rocky": {
         "ab": re.compile(r"^rocky(\d+)"),
@@ -112,12 +108,8 @@ OUTPUT_FORMATS = {
         "lsb": "opensuseleap-{}.{}",
         "docs": "-  OpenSUSE Leap {}.{}",
     },
-    "centos": {
-        "lsb": "centos-{}",
-        "docs": "-  CentOS {}",
-    },
     "centosstream": {
-        "lsb": "centosstream-{}",
+        "lsb": "centos-{}",
         "docs": "-  CentOS Stream {}",
     },
     "rocky": {

