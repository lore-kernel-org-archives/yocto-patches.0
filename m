Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F73D46636
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 22:46:58 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.710.1768517218191320545
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 14:46:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=GsH9GfXi;
 spf=pass (domain: konsulko.com, ip: 209.85.222.177, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c5389c3cd2so156820285a.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 14:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768517217; x=1769122017; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7vLdeJZjO1HlcdgrXGdKALHTlTVwbYNw7Lh4SA3MuY=;
        b=GsH9GfXijpmFK/kwUAeRuP0QJO0xGwWTSQLyMSuV7LfhJLeezPNgoEJ+/K+4me2cA4
         41fJmqszzj5xJhXPgM8VrO0gaiRljiQc2nJ5d5kI3Vp7evO+XVvbJe4ROtSf8mEvdYzp
         U4c216B2lZBZcF9qo4M5jzJk4kK1JgnZF6Cc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768517217; x=1769122017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o7vLdeJZjO1HlcdgrXGdKALHTlTVwbYNw7Lh4SA3MuY=;
        b=ghmszYQBibTMiCFNnhqx2UdIUrQzGEoHAilRWyIpwXFWTG2c1oG5b9XOqknjCcQ3VE
         oziOpCvTGqVR1dNDaXhEaZVXzLLlrbY+VMwS6QCZw+xoBnYuvLaJPzSpgFXli1V/pmN+
         dNKdBpTZt+S68Ebb4VdFL84jPGIxE/zoJY2n8evMw6ITn+p5ZK9Z3udCOSiYOhBjG4pj
         O0KUpBDLEjG+Sbj7uoAQm5GNof9Z2qrEORUQQYk+LreR3pbjqJd8tSduIgV778vMaYo8
         yWHOLY3U00fsnyZQIetAYUage5GEGpHXH/eRBwUCqsjALtCFQNki+Xe3C1AfqHUmYr/1
         W8IA==
X-Gm-Message-State: AOJu0YxkfQLOrOLYgrtiNApIDhzTg2gl92/+Jcr5ADwGwKdNe/vv7s6T
	EAEREijcSpy+NtyEySTvNe3UkHo/l0MYqINc7PZF06Is9yDskWerfATO1xkuUEM4FB+b4Mtyp+3
	LuCo4
X-Gm-Gg: AY/fxX45q96Lb1C7aNbfc3wRqqz3MsiCX3niGA2zKgdhP3L9tt+lgewjDi+zr6HBtQO
	0Sn0jAf7OuovLQnLdL3goLYTpl3pjUnRyageQeZ2+p04NFtViQmcrUUhQ1BZPj2eg1EQN7xeDPR
	+4Lj8pBI5neizueti8rat7E3ef41pxqhIaOFLa5qu4QuA7t/sIA2mKPLu+8MRBgyercQg+hbE6g
	/PuVWGdZ8BzW7CvVwvfijnZSRBrbhh5JQTJISa8h4WErm3nMm4HmiHaJF//7V/1xsugU2nDQf0+
	7qO/ENFhH1iRGlZ3yQxlmZj2onwb8BjCTGimjFzhXrpeUmCrghaw5AuvIak1RwgD2387ZIU+jfB
	o618mAuTa2aUtUnlhlDjKlDTiEzHj9QMXzxi8BM3s+e9BSaDOZ3k8GfhnFW5r1ZFuMgG/egsOhQ
	Ba1vYeIeXva4oZC+5aysQ4iaU/B2muV6qNk4GeO3hLUwG7PfXTShTzZLl71ZXRuLJUpLqn1X0JM
	JLk2YuQ+7akyaJiNyuQ1jlyjBLywkg7Emohe/RnQHz5moP5IIQS
X-Received: by 2002:a05:620a:4448:b0:811:3f8a:24a6 with SMTP id af79cd13be357-8c6a678e83bmr161166585a.53.1768517216928;
        Thu, 15 Jan 2026 14:46:56 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6040casm7921436d6.21.2026.01.15.14.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 14:46:56 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-security][kirkstone][PATCH 7/9] meta-security-compliance: Update lynis
Date: Thu, 15 Jan 2026 17:46:28 -0500
Message-ID: <80b6b58e40802c6b3ef5102701ced31d06653f16.1768515491.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768515491.git.scott.murray@konsulko.com>
References: <cover.1768515491.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 22:46:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2972

Update lynis SRC_URI to fix building, and while at it bump to 3.0.9
which hopefully be a transparent upgrade for anyone still on kirkstone.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../lynis/{lynis_3.0.0.bb => lynis_3.0.9.bb}                | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
 rename meta-security-compliance/recipes-auditors/lynis/{lynis_3.0.0.bb => lynis_3.0.9.bb} (84%)

diff --git a/meta-security-compliance/recipes-auditors/lynis/lynis_3.0.0.bb b/meta-security-compliance/recipes-auditors/lynis/lynis_3.0.9.bb
similarity index 84%
rename from meta-security-compliance/recipes-auditors/lynis/lynis_3.0.0.bb
rename to meta-security-compliance/recipes-auditors/lynis/lynis_3.0.9.bb
index f665e29..e72589e 100644
--- a/meta-security-compliance/recipes-auditors/lynis/lynis_3.0.0.bb
+++ b/meta-security-compliance/recipes-auditors/lynis/lynis_3.0.9.bb
@@ -6,9 +6,11 @@ HOMEDIR = "https://cisofy.com/"
 LICENSE = "GPL-3.0-only"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=3edd6782854304fd11da4975ab9799c1"
 
-SRC_URI = "https://cisofy.com/files/${BPN}-${PV}.tar.gz"
+SRC_URI = "https://downloads.cisofy.com/lynis/archive/${BPN}-${PV}.tar.gz"
 
-SRC_URI[sha256sum] = "3cc165f9007ba41de6d0b693a1167dbaf0179085f9506dcba64b4b8e37e1bda2"
+SRC_URI[sha256sum] = "f394df7d20391fb76e975ae88f3eba1da05ac9c4945e2c7f709326e185e17025"
+
+UPSTREAM_CHECK = "https://downloads.cisofy.com/lynis"
 
 S = "${WORKDIR}/${BPN}"
 
-- 
2.51.0


