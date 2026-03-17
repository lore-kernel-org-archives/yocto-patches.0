Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72834FEDA17
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 23:29:23 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2788.1773790159644545523
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Mar 2026 16:29:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=GqwXeehn;
 spf=pass (domain: smile.fr, ip: 209.85.221.50, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b4915161fso1809394f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 16:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1773790158; x=1774394958; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqbKRnZQChMb2hEygYeLBllXg9I6+CsGjOIRFeYZygc=;
        b=GqwXeehnrdhjv76vNC3/dXGrE7xvfdczcYQzBIC1xpIgPagFhe3XL1RW10DAC/9efL
         Eq+h8rHj4VKefwINOGKFCHexVhuuktJne5Jnw7ht/NwV5rZl/7tLleozaUZxOEySHHPI
         tvXkOWbMyEUaKbpsQXYqU2Cuk1Xh9aAaH6QDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773790158; x=1774394958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AqbKRnZQChMb2hEygYeLBllXg9I6+CsGjOIRFeYZygc=;
        b=bEFwj7Ydk1AfloMBqzI360T5QDwwGEsPmWJq5EnLVIOdVA2bYELxnBqfFoLDn8Meia
         Tl95nR+2DptEEeRt1JV/s+BeR6eQf9FmkrajVDXB1a/tq8WUQWbZUuARET//o2SAq/9Z
         5/DgdK329Czhlk5sBiDhVzw12GsGbeyLexbqcq3cV9M2SaWAxnI4ZCA29BVSRW4Zk96+
         SO1AhMPyF+NLciniA4mBuDmlwpKpsnnWkM6MxX3F5W93LrHhg77m8u0DEWZPDTexkvb9
         7Ny9ZCP/PE5StIh4EZIqgHSRLK+TQV856UourDiduADnHkVpsoXMeB8alYNvKWGJSTy1
         8W+g==
X-Gm-Message-State: AOJu0Yw3S0E0zV3gFwjdPPTGvvv9W85ztedn25hkBOOIrK/nFYrXR7Yq
	2+0w5iE+8RIJ5rYI9AknKpCbgrNj/CM4NNEXK4cB0Pwh1rEWrefBjs0L5CiBuqMsoz1A8G1fHAW
	VRXmy
X-Gm-Gg: ATEYQzx7AwS4+0UGSm3Z/LOVHUi6rM6Rpygris38YGQpuqbr5/UjFDHuHAeT9fJbOGp
	IZonBalvxHedVf86v4ceIH9qx9xIsHLj41n+yzeODOg4HF49d6cSXK7GkODOxtwKd8MS/Mp6AOK
	u11f8aKNDIgCsHE1RDkiXIOR0QYDyhZx5oqLhuKje8+uTp/HirN20Qvdd93s7qfa/QReEkQ5Z9G
	ZpJfUTlcKD1di9ddwS9oAT/6W0RiLdS0dkr3ATcRhVLu7i7i7lSrcz6O/RtscBsn9nMK2c2WJUo
	onBSMN9736I4tK7UqtiTo7GDymPfjO6iJrPDtgM/pwbukEMF27uNFoV6nDzQ1CvGQ0PENXWAl3B
	KNUP1BUAgNS8OB9PTG65w31grCQBu2u4fWRfnbg4YKmKcXv21yAJjrcRgK3cCbPHVeyKvbHe1Zr
	Hb2a8zVynWNsFBV1Sx1Aao7EQX7KkMLv7lmNsayNANqyOHn+CmpFGb/nti0P8g+bHKqXTv5dbRb
	M5QUfLt1ZCCVGJld7++UePd9cxe4aJ8iMTehg==
X-Received: by 2002:a05:6000:184d:b0:43b:42af:75e with SMTP id ffacd0b85a97d-43b527c92f4mr1859278f8f.44.1773790157838;
        Tue, 17 Mar 2026 16:29:17 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51892234sm2807644f8f.24.2026.03.17.16.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 16:29:17 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder-helper][PATCH v2 5/5] dashboard/bugtriage: Add a "View on Bugzilla" link
Date: Wed, 18 Mar 2026 00:29:02 +0100
Message-ID: <20260317232902.2404326-5-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317232902.2404326-1-yoann.congal@smile.fr>
References: <20260317232902.2404326-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 23:29:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3499

From: Yoann Congal <yoann.congal@smile.fr>

That link may be useful to jump from bugtriage page to bugzilla (e.g. to
then do bulk edit, ...)

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 scripts/dashboard/bugtriage/index.html | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/bugtriage/index.html
index 758284d..c154c9e 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -491,10 +491,11 @@
       navLink.innerText = `(${bugCount})`
     }
 
-    function populateTable(selector, bugs) {
+    function populateTable(selector, bugs, bzlink) {
       if (bugs.length === 0) {
         const p = document.createElement("p");
         p.innerHTML = "<em>No bugs found</em>.";
+        p.innerHTML += " " + bzlink.outerHTML;
         document.querySelector(selector).replaceChildren(p);
         appendBugCount(selector, 0)
         return;
@@ -525,7 +526,7 @@
       }
 
       const footer = table.appendChild(document.createElement("tfoot"));
-      footer.innerHTML = `<tr><td colspan="${fields.size}">${bugs.length} bug${bugs.length > 1 ? 's' : ''} found</td></tr>`;
+      footer.innerHTML = `<tr><td colspan="${fields.size}">${bugs.length} bug${bugs.length > 1 ? 's' : ''} found. ${bzlink.outerHTML}</td></tr>`;
 
       appendBugCount(selector, bugs.length)
 
@@ -546,6 +547,11 @@
       params.append("o0", "notregexp",)
       params.append("v0", `^(${ignoreProducts.map((s) => escapeRegExp(s)).join("|")})$`)
 
+      var bzlink = document.createElement("a");
+      var buglistURL = `${serverUrl}/buglist.cgi?${params}`;
+      bzlink.setAttribute("href", buglistURL);
+      bzlink.appendChild(document.createTextNode("View on Bugzilla"));
+
       try {
         const response = await fetch(`${serverUrl}/rest/bug?${params}`);
         if (!response.ok) {
@@ -553,7 +559,7 @@
         }
 
         const data = await response.json();
-        populateTable(selector, data.bugs);
+        populateTable(selector, data.bugs, bzlink);
       } catch (error) {
         console.error(`Failed to fetch bugs for ${selector}: ${error}`);
         alert("Error fetching bugs. Check the console for details.");

