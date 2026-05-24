Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7A0CD5BB1
	for <webhook@archiver.kernel.org>; Sun, 24 May 2026 12:28:28 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7245.1779625698314565703
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 24 May 2026 05:28:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Kjn/Q4N5;
 spf=pass (domain: konsulko.com, ip: 209.85.219.49, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8acb3daf2aaso157699756d6.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 05:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779625697; x=1780230497; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kFH7foQyZ/rkNWZkhpDpHnf66hqIv7cllgmxX9Zg674=;
        b=Kjn/Q4N51NmG2pMVQTMtNVLDO4DSDALzPR1M4vJLGdSIst8iyVGQ961y9nTuTV3Z+m
         da8RuDOEZXTGl2f0QTxYgaToyS0FiUE1fykMD/eQSJq1j3ilWS0AX63qvpfGoZuq+SFP
         L/98f4mFOfmUNbpfe4GlUIYP8E/UR3B7unL3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779625697; x=1780230497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kFH7foQyZ/rkNWZkhpDpHnf66hqIv7cllgmxX9Zg674=;
        b=alACOewZdktY9BpXcOFhCNMpf0KKJEs8/Nx0yrqxm3RWrKLsn0MM7OejZEFlEGetZQ
         ZRi5QCnYkbmVykriFw71CqbG2JQI/swaJAgEoTwOOM/Oatq+RNUcdoDIUJt0RqHUytC2
         ZMdnMYnaGiBznvKBBj55ncdXIyMNmCsQuW0Dvagem5g9tz6k2lY24/io5jN0OdXUZq1a
         QpeQsH7mfq0tBUE/z9ydIUm2EoowRnIL85HdJU4YW6ybqnvDaI6mEDE1+RGVVtWhIh9A
         PyFxUmkbtPF2fUJ8dd+Jprli9Q5icvHKk5UMO9u8jo/bTwD+rUIsggyniQkmOZCay8bw
         naRA==
X-Gm-Message-State: AOJu0YyQwqUw2EFH9+Dy98xLyOwJ5kFvIri1uRxSBPdVJsLaJrAtwIn5
	yy9TjVZE1Q/ZP9Jg387AS/Wu3N6iMHaAvzLjXzAbJCm34Nse8JjH7JOGmXKQOXxPqCkcfN34jwv
	HLR7H
X-Gm-Gg: Acq92OEvUd4SnakJZEOw6fV/vcUgxtWTMsE/yHrB6uvaOHGA6iNR3oj2udODIGREMcZ
	kqosBj/e5oY1zNQ1KUmZU5Im16YkBp5m59JyHsM1jlrZ79yfcYzjP43uSwSQ2cDm2pEf0s6tMMG
	wS/lyQRpXkh+sK44IQpu0p7AmfWL7tk1qeanBI6fbXttlW9F9aOmoD/NXrzQfCm0rAyNzu71tCG
	VLPDOZk2e/vQvrPZHJu0DYoRuaZg8Xz+nklgwWFDfeMDRvYYZZeuvkuAgrQ0shAnnuocgRS97UT
	IFidEbBNqeMxMarU6xNrEglpN0xqURWv610DqAHQSliUVL651oIZx3fZLKSmWxMYO5yivLUgqnk
	i91ihgzWfw/9lJ5S3TnxjMzEBWpwFGFF2f9NlF8cFZ9yMpvO4SQ4OCg/vAAGwNwzayXejCmi0cy
	h0YyngjMVrFw1aRB5mvSttiHesA8kry82tEe4bGJakhSJefHBIFOVWG0r9kLAzBrveU70QgC+m6
	+3VWzGpBVMpeWbM/E6o2af9Z8EzRpF78wWHPCNS4HUxSfiOxz7HU31pvWe+MdVdwGw3OIx3CCc=
X-Received: by 2002:a05:620a:29d3:b0:914:cb07:447e with SMTP id af79cd13be357-914cb0747b0mr681303685a.5.1779625697280;
        Sun, 24 May 2026 05:28:17 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb8c8034sm751989385a.7.2026.05.24.05.28.16
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 05:28:16 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 12/13] aide: fix pkg_postinst_ontarget shell script
Date: Sun, 24 May 2026 08:28:01 -0400
Message-ID: <18c343e92eb815c9ce0d7401c9d48c70baef7aaa.1779625557.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779625557.git.scott.murray@konsulko.com>
References: <cover.1779625557.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 12:28:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4032

From: "jason.lau" <Haitao.Liu@windriver.com>

- Fix conditional checks for AIDE_SCAN_POSTINIT and AIDE_RESCAN_POSTINIT:
  '[ 0 ]' always evaluates to true since it's a non-empty string.
  Use string comparison '= "1"' instead.
- Fix invalid use of '&&' inside '[ ]' test brackets. Use separate
  test expressions joined by shell '&&'.

Signed-off-by: Haitao Liu <haitao.liu@windriver.com>
(reworked for 0.19.3, fixed indentation)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-ids/aide/aide_0.19.3.bb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-ids/aide/aide_0.19.3.bb b/recipes-ids/aide/aide_0.19.3.bb
index 9a94ce2..68e3bfa 100644
--- a/recipes-ids/aide/aide_0.19.3.bb
+++ b/recipes-ids/aide/aide_0.19.3.bb
@@ -62,10 +62,10 @@ CONF_FILE = "${sysconfdir}/aide.conf"
 FILES:${PN} += "${libdir}/${PN} ${sysconfdir}/aide.conf"
 
 pkg_postinst_ontarget:${PN} () {
-    if [ ${AIDE_SCAN_POSTINIT} ]; then
+    if [ "${AIDE_SCAN_POSTINIT}" = "1" ]; then
         ${bindir}/aide -i
     fi
-    if [ ${AIDE_RESCAN_POSTINIT}  && -e ${libdir}/aide/aide.db.gz ]; then
+    if [ "${AIDE_RESCAN_POSTINIT}" = "1" ] && [ -e ${libdir}/aide/aide.db.gz ]; then
         ${bindir}/aide -C
     fi
 }
-- 
2.53.0


