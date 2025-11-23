Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9085CCFD31D
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 23:45:53 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4873.1763941550345103348
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 15:45:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=aO0T6u07;
 spf=pass (domain: konsulko.com, ip: 209.85.222.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b2dcdde698so560450085a.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 15:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763941549; x=1764546349; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQRKnYNYG5tVFr6/FD0FaSYV7dnjvw3T1FgluzMzzp8=;
        b=aO0T6u07/pmsyilS+lxrNtkwbIXnpcMgbLwSVGxP8zRbIcfMbOsl0ADSRX8HMmjple
         DV0uz6KSG6DjD5xU3KW34F1u/PsreYcuoxtLhvJDQ1wGCBkeVNFroTPOF0xKnippAxHi
         8SHFW9yuiAo3fuf+hWlSKeEmHe4euYrSEPCVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763941549; x=1764546349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yQRKnYNYG5tVFr6/FD0FaSYV7dnjvw3T1FgluzMzzp8=;
        b=M0b2AgSZ3+qWmnV6E5QXoT9rbwJG+DrrDJ0s/LXCcLPqqyRria1rv7vu27wZ39ta/M
         KI8xdedbwOb1kUn6HpA/mFoSooW1hd8TGdhWQeCaesaSQJycMlq2w+PsIe3DoemLxmYc
         RytPeiRVSwDIlJs+JlaHVqPOgEzrF9GhM6cP6Ypf4WvubuJBa1TYC6nTmIqZ/S/kANN/
         vdTLM/ce6GTe7d3IZ+91tz8Vj1JVPcJpVW+w6Vc/xyefM5OkirhTTkvKDo7CYQVoe46p
         I/jd6fp23vxEnlbAqGacOWiJ0211wrd8rAR+GA+JxrkvvARv29TW4Zx1bLuILvZBl39F
         Sy2w==
X-Gm-Message-State: AOJu0Yw2YarVtCY674ToUpmpznexzqxUIvjXKN5rHs1CKE2IHsBmfIsq
	ENKLjb0uIIJNm5xXgJoURaK+E01hnJA8p18yasMk7TgoEP4YNYaikCjgpHR4chlGWZLtPgFUkWk
	uumYP
X-Gm-Gg: ASbGncvpq4oRyH+LCULPJNzQi+rxSZhuU+HqK6KTgcpNTM0tPTDnkOFsEK4u1bZ4C+j
	qDyt2WT78DfWXxpYxcIVAObWpXWIRjYOu3ADw3Hdku4MQ3vrwyAHuGOJPw3y2QarNh0DS1WoPeq
	6SzraNFcmVKB7aDbwQYof4nEcxzKnuFFB4AxgFyHHsSfhNXbc3IBqfY3bqd5tSy4TTJ3uC4DzgS
	Zubtl1XG8LXqFJ1HizQiWGaq7IAzUT/NU0xJSpJ73OlE7IaMr4do4X19QDC2VWG8fsm4iGappz0
	pXv9Hu9F3MHtMgXJx1I7qzBY/kG+NwusptCGEu+5vUjYveVmxTwFkdOaHktadzzR8YTWI+7aHDl
	DnDqWdxt1XGiA7Fv78oXHRx07EjRbP/hjD+s092N304anEAOgqVO+o617lHHw2GYv2u9ia1f5Np
	bEnyWlwaq5RxZgymtFpN3sFiq0bVBSwCFu+3hxFPdhR6jIZx8WinDMXIdFGOTkCnM=
X-Google-Smtp-Source: AGHT+IHFSFQqqtBAYqX4nZy5dtub+qTgixiyWhnFmApi+mLCev3J7MmRlyBgXxF8YOo8zuIKhLISqg==
X-Received: by 2002:a05:620a:3710:b0:8b2:ea5a:413d with SMTP id af79cd13be357-8b33d4afdefmr1140911185a.86.1763941548937;
        Sun, 23 Nov 2025 15:45:48 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932db59sm843706585a.1.2025.11.23.15.45.48
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:45:48 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 30/32] suricata: install classification, reference configs
Date: Sun, 23 Nov 2025 18:45:10 -0500
Message-ID: <6e1bac491d9a9243f3e8cbd8ee3bdbe2dad27c94.1763938436.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763938436.git.scott.murray@konsulko.com>
References: <cover.1763938436.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 23:45:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2688

From: Clayton Casciato <majortomtosourcecontrol@gmail.com>

suricata.yaml references these configs

Resolve:
<Warning> -- could not open: "/etc/suricata/classification.config": No
such file or directory

<Error> -- please check the "classification-file" option in your
suricata.yaml file

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
(cherry picked from commit 9a49fcbd05e46cafb0a2300a035a9528242bd4b2)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-ids/suricata/suricata_7.0.0.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-ids/suricata/suricata_7.0.0.bb b/recipes-ids/suricata/suricata_7.0.0.bb
index 7a6b930..021575f 100644
--- a/recipes-ids/suricata/suricata_7.0.0.bb
+++ b/recipes-ids/suricata/suricata_7.0.0.bb
@@ -122,6 +122,8 @@ do_install () {
     install -d ${D}${sysconfdir}/suricata ${D}${sysconfdir}/default/volatiles
     install -m 0644 ${WORKDIR}/volatiles.03_suricata  ${D}${sysconfdir}/default/volatiles/03_suricata
 
+    install -m 0644 ${S}/etc/classification.config ${D}${sysconfdir}/suricata
+    install -m 0644 ${S}/etc/reference.config ${D}${sysconfdir}/suricata
     install -m 0644 ${S}/threshold.config ${D}${sysconfdir}/suricata
     install -m 0644 ${S}/suricata.yaml ${D}${sysconfdir}/suricata
 
-- 
2.47.3


