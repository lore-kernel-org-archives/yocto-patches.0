Return-Path: <ninette@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28E8C25B5F
	for <webhook@archiver.kernel.org>; Wed,  8 May 2024 15:31:53 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
 by mx.groups.io with SMTP id smtpd.web11.15795.1715182306398000906
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 May 2024 08:31:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=TQgPbs5/;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.167.52, mailfrom: ninette@thehoodiefirm.com)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51fea3031c3so5902397e87.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 08:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1715182304; x=1715787104; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=evAHsBxmw/rBNXLjEq4jwvU2+phYJhtIeypPe2w/c2g=;
        b=TQgPbs5/URDCdn+URr/NSBlmGTWsP+2pLRLcoqWtOxU9/BLsES4kh6kCssMZqTq+qv
         YY+m/L/o/icR7gwK5jAzjOwRwh4FQ7VSFj0gHBn3rVfcY4X9j9xzcZ0fTU3D9wFT0wEb
         +qegUzM6oM5zvVJ8sngGYkUId9n6tdq+S2z917oFFzFUC4Dg2OX3AF0KILNoZvm9+Zij
         3ML2745RwMEwjn3KW4PLi9IugSKILzjWRLNtt3NKNK/XailKWm6g+WNO4xSWzS/6O1iY
         EJQCDtRqCCGPc0T0fZPzpiKb3dIF3coBdkupcHisJSXnE4Nfpa2xiDbXzPR/Fbz5T1qq
         JMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715182304; x=1715787104;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=evAHsBxmw/rBNXLjEq4jwvU2+phYJhtIeypPe2w/c2g=;
        b=QT1CI34OuGtO1Wb+nPKYwGAYuwkfNcUp4Qmp/vEhmEYrDNgTQlj3rUirjr9fsDnnkP
         6HLvUZzFHZ4BH0L1FRduPxGI1hcvl6KNFIEdElwWKbk7TGwglFpk83EePlC03PtRIQsR
         PH+LzZygtg8oIVOolro6m0XhY1jbJXKPqMl9mN8vn8xA+2t9An1GDlbF4f1pYJOTZTQK
         diMESMAoppA/HiRUnb/NwOg2AI8xnTbGg4wpbjnA7RYibhOAZJ5LSg2miobpzk/6sAoL
         lP3i9VX+OBxqT4f4bTQgBJQjvn4ZNBgnNWvrtutjKDK8mddQlrVduEkH7RyDVbK1hoZx
         kJFw==
X-Gm-Message-State: AOJu0YyXYqlubZCx0iWoRGrE2qujrjXgVYscpnefOA3Ty5/yX3Vpnx8q
	g2YvWsQOb/4+H4cMDUQ/rLLFFux3YIELLkZBrsdnRAInJn8/hWIxKPHP27GvxsCIj4UGtC7WHPZ
	L
X-Google-Smtp-Source: AGHT+IHCEP3qNcVBt5h/rPRR8jHqhJK5r4BGPM6viYbaEFNtz/6n4KkDjUrnNo/ulNwKn0DtO1YwSw==
X-Received: by 2002:ac2:4109:0:b0:51c:5570:f570 with SMTP id 2adb3069b0e04-5217cf3cb96mr2285225e87.59.1715182304581;
        Wed, 08 May 2024 08:31:44 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeba4.dynamic.kabel-deutschland.de. [95.90.235.164])
        by smtp.gmail.com with ESMTPSA id c17-20020a1709060fd100b00a526a992d82sm7784897ejk.4.2024.05.08.08.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 08:31:44 -0700 (PDT)
From: Ninette Adhikari <ninette@thehoodiefirm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie,
	Alex Feyerke <hello@alexfeyerke.com>
Subject: [PATCH 08/12] index.html: Add description to recipe count section
Date: Wed,  8 May 2024 17:31:23 +0200
Message-ID: <20240508153131.94270-9-ninette@thehoodiefirm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240508153131.94270-1-ninette@thehoodiefirm.com>
References: <20240508153131.94270-1-ninette@thehoodiefirm.com>
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 15:31:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/99

From: Alex Feyerke <hello@alexfeyerke.com>

Also moves chart out of section element.

Signed-off-by: Alex Feyerke <hello@alexfeyerke.com>
---
 patch-status/index.html | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index aacc6496..8089a1c0 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -332,17 +332,20 @@ SPDX-License-Identifier: MIT
     <div id="malformed_chart" style="height:400px;"></div>
 
     <section>
-      <h3>Recipe Count (OE-Core meta directory)</h3>
-      <div id="recipe_chart" style="height:400px;"></div>
+      <h2>Recipe Count (OE-Core meta directory)</h2>
+      <p>
+        This graph displays the number of recipes. It provides insights into the growth and evolution of the OE-Core meta directory by tracking the number of recipes over time.</p>
+      <p>
+        A recipe in the context of Yocto and the OE-Core meta directory refers to a set of instructions or metadata files that describe how to build a particular software package. These recipes typically include information about where to obtain the source code, how to configure it, and how to build and install it into the target system.</p>
+      <p>
+        <em>An increasing recipe count indicates the addition of new software packages or updates to existing ones. It reflects the growth of the OE-Core meta directory over time.
+          A higher recipe count often means better software coverage, allowing users to build a wider range of software packages for their embedded systems.
+          With more recipes, there’s increased maintenance effort to ensure that recipes are up-to-date, correctly configured, and build without errors.</em>
+      </p>
     </section>
 
-    <h3>Raw Data</h3>
-    <ul>
-      <li><a href="patch-status-pie.json">patch-status-pie.json</a></li>
-      <li><a href="patch-status-byday.json">patch-status-byday.json</a></li>
-      <li><a href="cve-count-byday.json">cve-count-byday.json</a></li>
-      <li><a href="releases.csv">releases.csv</a></li>
-    </ul>
+    <div id="recipe_chart" style="height:400px;"></div>
+
   </main>
 
   <script type="text/javascript">
-- 
2.39.3 (Apple Git-145)


