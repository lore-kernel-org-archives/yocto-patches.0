Return-Path: <ninette@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD501C25B74
	for <webhook@archiver.kernel.org>; Wed,  8 May 2024 15:31:53 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web11.15802.1715182308785923101
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 May 2024 08:31:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=Mb++g7VU;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.218.44, mailfrom: ninette@thehoodiefirm.com)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59a5f81af4so1186906166b.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 08:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1715182307; x=1715787107; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ftDLWh3DvfW347KPFhWSVntri6iGkk29S6vvilINyBc=;
        b=Mb++g7VUVcPOrryxkNIicVHA1OUb6NK0o+1LM6gQ0B42JbF2aWHgMer/R0MB5fa35f
         rjE+xUi4M1OeaypiTp8Q0tn1vXjGIRs6cbpLALAVk9IxWODH/GtiYzVeedNmVMsBfHjp
         EPDQ9zwOQk2RVLmm2ROIWN8IxShXDvcBP9WrCypMqveD687Aqdt4BS5CMKtxN9IB0lh9
         hXZI+myS0nfB7q98ag30UE5aZ2f8Ib7H3mfrjz0J+mbkeSGwdRy4URrZ9vzUV4ZnWuMK
         0xwkMb5OUKoXK3imPp1d8BbJmCI3hZ0Z9EIFKZcdYJGTwOPc3PAt8NvxrqNoMnskezJn
         A4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715182307; x=1715787107;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ftDLWh3DvfW347KPFhWSVntri6iGkk29S6vvilINyBc=;
        b=pWXU6ZZ4KQ2e76PB8xIZAqTEdlrcRPrImwRbRDB2SUm52Przf6srWB2xAXEKsNKT5i
         dWP4WPZu180UAIhM7VcFk8RtxjrbNPRKzuQpX9Uo0MOyW0bJ1kv+kEVTcpFI6sYBr0QI
         nhPk4dpcmkwrtRnXLILQUG4WM0eJG86nFiiJvOiwRPETPx7vLbx9ikPAarz289aCJvLd
         3swR/4bQ2YOeEE1FccttE3fwoQz3XgV/9ArfZ3XQtqqQ/xGxRdGr1IUjFlQbXrP+RYYj
         O+geMqHt3Kts6pRpO5cSzeF/4s0vf6RBVs1YR7crr+uCRgo+F42L67v/7ds29WaHkNkD
         03uw==
X-Gm-Message-State: AOJu0Yx0QEmLWTFAvnXCIPcjUc8I5cHNWVBKl+LgSxSW1QK+LQpzjTS5
	+mhSrxFfrwWuOUEAw/j6oy0Hs51ekPipeHkWZa+SaRjX6yQmhKFB8D5sDLaQtdl98wzjmnr3gs3
	O
X-Google-Smtp-Source: AGHT+IGOwZYmFzDGNwAYccNrz5pg7oqpdQa0Rd9wHJBXzABtRYnC46ncHE0QMEYzfAEjEh0Q3NVQmA==
X-Received: by 2002:a17:907:74b:b0:a5a:5c5:a9f7 with SMTP id a640c23a62f3a-a5a05c5aeefmr152479666b.8.1715182307304;
        Wed, 08 May 2024 08:31:47 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeba4.dynamic.kabel-deutschland.de. [95.90.235.164])
        by smtp.gmail.com with ESMTPSA id c17-20020a1709060fd100b00a526a992d82sm7784897ejk.4.2024.05.08.08.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 08:31:47 -0700 (PDT)
From: Ninette Adhikari <ninette@thehoodiefirm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie,
	Alex Feyerke <hello@alexfeyerke.com>
Subject: [PATCH 10/12] index.html: add line numbers to CVE link lists
Date: Wed,  8 May 2024 17:31:25 +0200
Message-ID: <20240508153131.94270-11-ninette@thehoodiefirm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240508153131.94270-1-ninette@thehoodiefirm.com>
References: <20240508153131.94270-1-ninette@thehoodiefirm.com>
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 15:31:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/101

From: Alex Feyerke <hello@alexfeyerke.com>

Improves readability.

Signed-off-by: Alex Feyerke <hello@alexfeyerke.com>
---
 patch-status/index.html | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index 31c5bfe5..a847a456 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -412,9 +412,9 @@ SPDX-License-Identifier: MIT
         html += '<details>';
         html += `<summary class="sub">${name} CVEs</summary>`;
         html += "<ul>";
-        for (const cve of cves) {
+        for (const [index, cve] of cves.entries()) {
           html += '<li>'
-          html += `<a href="${cve}" target="_blank">${cve}</a>`
+          html += `${index + 1}: <a href="${cve}" target="_blank">${cve}</a>`
           html += '</li>';
         }
         html += "</ul>";
-- 
2.39.3 (Apple Git-145)


