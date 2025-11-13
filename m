Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A17BCD98D6
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 20:14:13 +0000 (UTC)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2214.1763064852645185146
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 12:14:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=oC0f7ZN6;
 spf=pass (domain: konsulko.com, ip: 209.85.160.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4e88cacc5d9so10160211cf.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 12:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763064851; x=1763669651; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3bbVwDQN/WJST5RUGTwe4qfZIfRW5ugnPD0kCm9iyko=;
        b=oC0f7ZN6gbo17ymRr4Q5h8DyHy3gPtOKfwsu1ARx3VBIYUdS5ucJu7M4Hu3FBLG7mR
         SKyNZqeH0YOAgghiZT1bYodCmlmbcYTlLyyzoZQIHN5IxNj/w8orYmTyYV8fNuKDr8yz
         FU3tKNa+oyV33ab5iF3V7jd7cWqC+U/MiQKU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763064851; x=1763669651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3bbVwDQN/WJST5RUGTwe4qfZIfRW5ugnPD0kCm9iyko=;
        b=u/tekuIdxO6t/WnuRVhghCj1rv4TOjJNve4DhYFRlG6UkAFzzKeXsbYTDRtK2WT0Sz
         fINz+ax5qobxIkrZvY+Iw8X58EIH+qPKh4Wqez2LvB/bMx+GnWpELUeQHB7l+juicWNJ
         sbIRFmoeezaCUfrUlxzGpn+uPqMXtVixDs4WrkIsaJuevacvlAuROIxmkUQHaZhDCP5i
         ff3a4BcdqSfSpXMp5X8ElGOP7aIre9EgVwFB6UTeV8mGm+oszHlE9HpX91/lRozg29fs
         ppEwK4gWu2HDtMnZHU3JU5cRnw74qmV3bRjwAMz5StTDWVPfuZLepd6+4FgF6WI4G1EA
         9FPA==
X-Gm-Message-State: AOJu0YzYEDjqPP97Sn/4SA9YRraNKg9Ek2GF5b/IS/6MDttjeIldPt3e
	fLjghuzqU0MtRoDtcaU7SbaBYAgu4Fhq2tR+zEnM4vDOg2Gnt2oPsIEGia5zArNozyqVp7Qpu+I
	0+VOC
X-Gm-Gg: ASbGncuHygvgVfbHDllghZeopsuaQQh1V/p4rOKVWoQbmZDv6dBrqmUdJkiUdSj6QIk
	AP8rFPUOAFK+iW7s/x8/UvPsMVXxeDhzhEBrAfsroImCZmCy8WrAyIlzR4LXLBFzHQIE6TuXC4d
	V8f70Z0PLxD7UE6aWqXQfFFpP278sAb9ogsh6qqYrrm4FV7/6+l4P88gORb+HpVPkjlEo81Qz2h
	QmnnU5+Gij5rg4RUqB+vHeaTHJvyiFlOpXVy3HxYSeUJfcdOJK9knJR3ak+upY4JAtY1Mn9TkGz
	DLloPmhRX4kjaYL0Vyz0IgnW8gHomUXOt2blQabPiqje+5V9CabhhLGFWu7nJYnaNYu5dG+aWfU
	JJYDgnohMVwBY5npMry/lR1oz4XVFQFYGzZ8WlWfQ82eY0tD9Q3hjUdfBhpjIQtOEWH7cRpZ2Rk
	qZRjH3cDNT6+EnEAWshAeg5TJ+BJ7aR+pp6WdmabosaOVKkchWx0+Y
X-Google-Smtp-Source: AGHT+IHO2dS5hvTajK1dXp/OglffcwMfwnqRUQo4Z+m0IIXbxO6MwKge4EbPHYd8d920oTdW7wX+EQ==
X-Received: by 2002:ac8:5844:0:b0:4b5:ea1f:77ec with SMTP id d75a77b69052e-4edf1f4b087mr14003171cf.0.1763064851417;
        Thu, 13 Nov 2025 12:14:11 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede881acc7sm17636211cf.28.2025.11.13.12.14.09
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 12:14:09 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 3/6] ecryptfs-utils: Add CVE tag for ecryptfs-utils-CVE-2016-6224.patch
Date: Thu, 13 Nov 2025 15:13:39 -0500
Message-ID: <b639be32ad038d49091ddc1ae1aaf3e2c7e5bbc5.1763064477.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763064477.git.scott.murray@konsulko.com>
References: <cover.1763064477.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 20:14:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2547

From: hongxu <hongxu.jia@eng.windriver.com>

Follow Yocto policy to add CVE tag to CVE patch

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 .../ecryptfs-utils/files/ecryptfs-utils-CVE-2016-6224.patch      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-security/ecryptfs-utils/files/ecryptfs-utils-CVE-2016-6224.patch b/recipes-security/ecryptfs-utils/files/ecryptfs-utils-CVE-2016-6224.patch
index a457d79..c0a86e9 100644
--- a/recipes-security/ecryptfs-utils/files/ecryptfs-utils-CVE-2016-6224.patch
+++ b/recipes-security/ecryptfs-utils/files/ecryptfs-utils-CVE-2016-6224.patch
@@ -14,6 +14,7 @@ the patch comes from:
 https://web.nvd.nist.gov/view/vuln/detail?vulnId=CVE-2016-6224
 https://bazaar.launchpad.net/~ecryptfs/ecryptfs/trunk/revision/882
 
+CVE: CVE-2016-6224
 Upstream-Status: Backport
 
 Signed-off-by: Li Zhou <li.zhou@windriver.com>
-- 
2.51.0


