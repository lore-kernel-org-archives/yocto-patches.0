Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2CCFF6E97
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 23:29:23 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2783.1773790156757395954
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Mar 2026 16:29:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=a0VNcZ6T;
 spf=pass (domain: smile.fr, ip: 209.85.221.47, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b4d73463dso832796f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 16:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1773790155; x=1774394955; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDXnAJtz5sC7fxf1MsYj0X4ZhS07eLltBT8fxod7AEU=;
        b=a0VNcZ6Tcx0ifICUMXunKPb+ISX5HyMkTykgX4f/Kwl1raHBaYxuy1FVtOZgwU7R4n
         pj8UtUrNZzCJ5I1U+5v7TfcsgVQ/bGJsPgfO98hbXl3mmR22AB7QJI4SEqRL+GOMPrrD
         lO8yTYZgSmdRKgsEmVA5+0JRSts5/SLyrKbB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773790155; x=1774394955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CDXnAJtz5sC7fxf1MsYj0X4ZhS07eLltBT8fxod7AEU=;
        b=CJtTItYVS9YXM3UPh/a2jqDxjQdv3d3sDxjEp7sNnEue0efG0YsQqVO6C7zfZpMzlp
         wukII6NYZBEzNcRee6EZ0ZIW1kljzlDD/1nTIfuTzjkReVDIPZgrFtRP/pnHctssB3kn
         qfYJEfcNkQloJMry9I1nRwgkZmmZA7O3WI9kf9he3TSmhT2qXMPkNgIzLJT2JBKdLjeT
         Afv4iBH/KWiQRY2ISQR0iMM+EQbEW883T9oppK7biuZ8Is5zgwIj/hWYcjI4DtGPjzz/
         vUIbQ4c21E1PC9F7f/p2BWC7VPNVRM3dLuIRmQYtxQqGWZAE97AJ5se5yetGwDSJ8ufu
         Mz9g==
X-Gm-Message-State: AOJu0Yy0t1uvIk0pYzDGiKl0/s84oSuyagAeHqYgi9XXTjwrWvYUQKVD
	DHF6YJJXgQXglZUUi9rskZ5Cq4o3kEvx7atGgObM9OZNTUXNuJdg+09Yd97uC5KHhkQuMwJrG4v
	zAWyu
X-Gm-Gg: ATEYQzxhcAbpqhqxviqaXcq9u/uSrzCt96b0wl/8Yjfb4p4DepXIygITqrkxjO8f+nz
	4WWx08yLVt6dNK/qZxWFYPqYVQpGJK1Mep3X1Vk/YZgdFNUCs0yIaEZQ5uGdZtJ792O5yEHMigl
	dzJUvJ2egNpog084nLNsYXFTQ2KHRdQeywibrYoeKK7ayKlY0laUgDIoVdvmRiuAhmjFeTWZHMA
	/8dpo0Aw8GPvkJpTtyH5cyiLT6RHRx1b92iYOtjDkowh3//rxEr9hk1mlV1lgu53MRxImvU340F
	ua8zmJLPjOOPzHG2ZXBk1/P8u7Vjx1lWjzWdkjXl/FlTdBuf/Crfe9gKt7Hi4zb2leZFNgZWSzS
	Bz6Y6poa+rIl+UHCyeQ8fsnhJii3xiG0E6dXOCFfcq4dmFVb+6bfzX5WbkYOVavep/L9tSkoi13
	/Qn6m8QjP4isbyv57XkH5G0IJD1bB7XUcbv5x7OY5H8r9CNGbLshdfumW1UHo4mjr05kYmThPZ3
	7E/tbInrbldKh4A2li2OtPNBvw=
X-Received: by 2002:a05:6000:2010:b0:43b:3cdc:941f with SMTP id ffacd0b85a97d-43b527aa708mr2017993f8f.17.1773790154789;
        Tue, 17 Mar 2026 16:29:14 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51892234sm2807644f8f.24.2026.03.17.16.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 16:29:14 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>,
	Ross Burton <ross.burton@arm.com>
Subject: [yocto-autobuilder-helper][PATCH v2 2/5] dashboard/bugtriage: Re-order Wrong Milestone above Old bugs
Date: Wed, 18 Mar 2026 00:28:59 +0100
Message-ID: <20260317232902.2404326-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317232902.2404326-1-yoann.congal@smile.fr>
References: <20260317232902.2404326-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 23:29:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3496

From: Yoann Congal <yoann.congal@smile.fr>

This should match the bug triage meeting order.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
Cc: Ross Burton <ross.burton@arm.com>
---
 scripts/dashboard/bugtriage/index.html | 28 +++++++++++++-------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/bugtriage/index.html
index 3ea5494..e62d211 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -256,9 +256,9 @@
             <li><a href="#reopened-container">Reopened<span class="bug-count"></span></a></li>
             <li><a href="#abint-container">AB-INT<span class="bug-count"></span></a></li>
             <li><a href="#needinfo-container">Need Info<span class="bug-count"></span></a></li>
+            <li><a href="#oldmilestone-container">Wrong Milestone<span class="bug-count"></span></a></li>
             <li><a href="#inactivebugs-container">Old Bugs<span class="bug-count"></span></a></li>
             <li><a href="#inactivefeatures-container">Old Features<span class="bug-count"></span></a></li>
-            <li><a href="#oldmilestone-container">Wrong Milestone<span class="bug-count"></span></a></li>
             <li><a href="#newcomer-container">Newcomer<span class="bug-count"></span></a></li>
             <li><a href="#retest-container">Retest<span class="bug-count"></span></a></li>
           </ul>
@@ -363,41 +363,41 @@
           <div id="needinfo"></div>
         </section>
 
-        <section id="inactivebugs-container" class="table-container">
+        <section id="oldmilestone-container" class="table-container">
           <span class="spread">
             <span>
-              <h4>Inactive Bugs<span class="bug-count"></span><a class="reload-button" onclick="reloadTable('#inactivebugs');">Reload Bugs</a></h4>
+              <h4>Wrong Milestone<span class="bug-count"></span><a class="reload-button" onclick="reloadTable('#oldmilestone');">Reload Bugs</a></h4>
             </span>
           </span>
           <p>
-            All open bugs that haven't been altered in two years.
+            All open bugs that are targetted for a milestone in the past: they
+            should be closed if fixed, or moved to a future milestone.
           </p>
-          <div id="inactivebugs"></div>
+          <div id="oldmilestone"></div>
         </section>
 
-        <section id="inactivefeatures-container" class="table-container">
+        <section id="inactivebugs-container" class="table-container">
           <span class="spread">
             <span>
-              <h4>Inactive Enhancements<span class="bug-count"></span><a class="reload-button" onclick="reloadTable('#inactivefeatures');">Reload Bugs</a></h4>
+              <h4>Inactive Bugs<span class="bug-count"></span><a class="reload-button" onclick="reloadTable('#inactivebugs');">Reload Bugs</a></h4>
             </span>
           </span>
           <p>
-            All open enhancements that haven't been altered in two years.
+            All open bugs that haven't been altered in two years.
           </p>
-          <div id="inactivefeatures"></div>
+          <div id="inactivebugs"></div>
         </section>
 
-        <section id="oldmilestone-container" class="table-container">
+        <section id="inactivefeatures-container" class="table-container">
           <span class="spread">
             <span>
-              <h4>Wrong Milestone<span class="bug-count"></span><a class="reload-button" onclick="reloadTable('#oldmilestone');">Reload Bugs</a></h4>
+              <h4>Inactive Enhancements<span class="bug-count"></span><a class="reload-button" onclick="reloadTable('#inactivefeatures');">Reload Bugs</a></h4>
             </span>
           </span>
           <p>
-            All open bugs that are targetted for a milestone in the past: they
-            should be closed if fixed, or moved to a future milestone.
+            All open enhancements that haven't been altered in two years.
           </p>
-          <div id="oldmilestone"></div>
+          <div id="inactivefeatures"></div>
         </section>
 
         <section id="newcomer-container" class="table-container">

