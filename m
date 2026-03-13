Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B5A105F7B0
	for <webhook@archiver.kernel.org>; Fri, 13 Mar 2026 14:00:53 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16496.1773410450295556835
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Mar 2026 07:00:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=Jj91RPLT;
 spf=pass (domain: smile.fr, ip: 209.85.221.41, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439c56e822eso2344893f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Mar 2026 07:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1773410448; x=1774015248; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhcVGPmCAx7eBWz+bzYahpnoNfb86+G0jMd9gPecN50=;
        b=Jj91RPLTVyQ4FRxixJ7/kU/L1hEP42nj8KIhuwCkxLuKxvC2ad7eftiuxW3IRJ5KZz
         0y3w6JGAy1LUXvYbi4krwmhUdsL30PRkojaOfV4cQgmnpQAx3vbzVRJwyYZ4de2t1CPx
         x7Ik5szXsBIHmLc4VkTCy2TsTV+FDArpKQVNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773410448; x=1774015248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fhcVGPmCAx7eBWz+bzYahpnoNfb86+G0jMd9gPecN50=;
        b=WLIxAOoenXPjXAGhVNtRmQntlBayxuABRKlRcHeWKyIVYCoQlni31RrbanmwQsCqN/
         OPbAT5B3ix4mi3sdM5qm0mGsRg6JoGXn/4kmV8AifCrhvfdlYP8vjudsZ/MbWoNj1gGD
         45SvYHaePaBtOYlOPqK/vBHkaInRkjncJKNWSIfK765vDHUt8/Kr0wFMXoMG3RY/k6Uz
         sryQ7eUsyMhX3j2UtvaosVFAjL4XlkxcQOFN3TV37Cpo4OTZW7HODsL1omfFDjdu8/+Z
         U3pi0AFAcjvKUpyIewSoNNp6pm/V11aq2Jhzs2Cas+pNMayB0mqfW82LzZRCv+V0sZYR
         vO9g==
X-Gm-Message-State: AOJu0YxL5DFgT9B2QHa09JlrlljuVg9+Tk1UWhOHhg4r8j7VafIjmOmP
	OXDkscg8CnKJhrmYnY3P4i35gWLcD/vEsv4iSd5IKNPUy609i5ll0ucrsbnRN3hepIlF4XbJCFW
	Bkqrq
X-Gm-Gg: ATEYQzwduMxM8wXhdfm2RJpGtM/tRo9Pv0yVnwtOuYhqhzNiyExsI/mYDDOTxAQO4C8
	ItC7EEdy3GcZiG/tWn9EHeOyOzfBOQ7S4RxYS0gflsvO37O+NfVmsUkSLao7lA4LusSQFa4CrAf
	tbnT6oVbuBKmjyBzO5aYtUoVIuadzXHqU05wamazQ1x65odgCx14Y/wyYuAKn2mmRL4T4+QfQeZ
	iycZz9VybYlcm6WKj3XNyD741WkGka9bgCs0/omC1WacoKh9knLMeL6UFexSt09V9vAKGCuT8U0
	ElZEo950MMFLTH11yOCaE5ssdCU6Mvr8g5+fx+jeDH9oXchvHOUu80yM0XTD3+cdmZTnnq1bSpG
	DZB2aVQrS+0yQOJh6ygfuZBg5FHImNonaaqeQiWa3iucXYtmi+ivGpK2lQQBH+JXpBn5wyCSCRX
	WCPjV33Mh/z9VZ74gWBj/j7EivyAdcbT0jXL1AHwl0RDcGrstGTYuY6sg3ETVlUdutbFHlepv6c
	O/1FQOFiqSDQWfRo5dh/i4SaxNJ
X-Received: by 2002:a05:6000:4013:b0:439:ba75:7db7 with SMTP id ffacd0b85a97d-43a04d7b3b5mr6752239f8f.7.1773410448077;
        Fri, 13 Mar 2026 07:00:48 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa001ac8ae6baecd7e1d.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:1ac8:ae6b:aecd:7e1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43a0b2db487sm2056109f8f.28.2026.03.13.07.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:00:47 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Ross Burton <ross.burton@arm.com>,
	Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder-helper][PATCH 4/4] dashboard/bugtriage: Add a "View on Bugzilla" link
Date: Fri, 13 Mar 2026 15:00:29 +0100
Message-ID: <20260313140029.805927-4-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260313140029.805927-1-yoann.congal@smile.fr>
References: <20260313140029.805927-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Mar 2026 14:00:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3457

From: Yoann Congal <yoann.congal@smile.fr>

That link may be useful to jump from bugtriage page to bugzilla (e.g. to
then do bulk edit, ...)

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 scripts/dashboard/bugtriage/index.html | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/bugtriage/index.html
index 9a773aa..6c782dd 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -200,11 +200,11 @@
       ["assigned_to", "Owner"],
     ]);
 
-    function populateTable(selector, bugs) {
+    function populateTable(selector, bugs, bzlink) {
       if (bugs.length === 0) {
         const p = document.createElement("p");
         p.innerHTML = "<em>No bugs found</em>.";
-        document.querySelector(selector).replaceChildren(p);
+        document.querySelector(selector).replaceChildren(p, bzlink);
         return;
       }
 
@@ -230,7 +230,7 @@
       }
 
       const footer = table.appendChild(document.createElement("tfoot"));
-      footer.innerHTML = `<tr><td colspan="${fields.size}">${bugs.length} bugs found.</td></tr>`;
+      footer.innerHTML = `<tr><td colspan="${fields.size}">${bugs.length} bugs found. ${bzlink.outerHTML}</td></tr>`;
 
       sorttable.makeSortable(table);
 
@@ -245,7 +245,11 @@
       const spinner = document.createElement("div");
       spinner.setAttribute("class", "progress")
       spinner.innerHTML = `<div class="indeterminate"></div>`;
-      document.querySelector(selector).replaceChildren(spinner);
+      var bzlink = document.createElement("a");
+      var buglistURL = `${serverUrl}/buglist.cgi?${params}`;
+      bzlink.setAttribute("href", buglistURL);
+      bzlink.appendChild(document.createTextNode("View on Bugzilla"));
+      document.querySelector(selector).replaceChildren(spinner, bzlink);
 
       try {
 
@@ -255,7 +259,7 @@
         }
 
         const data = await response.json();
-        populateTable(selector, data.bugs);
+        populateTable(selector, data.bugs, bzlink);
       } catch (error) {
         console.error(`Failed to fetch bugs for ${selector}: ${error}`);
         alert("Error fetching bugs. Check the console for details.");

