Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7587EC41513
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 20:23:08 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.4483.1718742184701805537
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 18 Jun 2024 13:23:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZKfYuOU+;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42179dafd6bso1298345e9.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 18 Jun 2024 13:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718742183; x=1719346983; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pEc2IyZQ2b91uzi16hB0udAMfSBfMSDjtm/WRBBhBU=;
        b=ZKfYuOU+Js+3nr9fyPRH67HzdGo6kvOIusi2Zh78aobs5TVqj1T6jA0QvyKFQ1sz1N
         JuJiXESSgt3MFhcP2imQdOrkm49SazHhiWssLzQ/Hdm2BC03i6O9dLGbDnqlq4hz69Jv
         Lza52ajlY2Olk4UBA8KO73RZKqOu0t0m6S7UsrqZrv2Sym6P7xmdWugOyZaKLNRbqiaL
         vU/Pioqi0Ye13waqdI2GGa1KHAYIAbIVFMAUwdqsi3+AoREr6LwiB7bNnkirryLmcFzW
         eHuHmeesaq8EN1SzCpDl9k1AUokcex6+lCrjc3R0gs5yexauk4S9VdXNYRqr9mW1cgg9
         /MFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718742183; x=1719346983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pEc2IyZQ2b91uzi16hB0udAMfSBfMSDjtm/WRBBhBU=;
        b=i0xhcNZSMNSl55hmy9gHIYp7b4kkw7rXTU8rjvKEhqBEQ5cg4vgtQAj1NWBviTRi8o
         ckjZlnQD4MehrdZ5lG10RRd7N8taGKKCtjz5DVxl3xzIaJYrerIj1h7+lu+YzB94L94d
         1DhlhLZ0haO+csMQQklF4Ni7/S5luE7L6vHq/m1oH9B94gHv9A9/vLZXZFgDik9FNXOU
         tLaiJ8VDjC/m6kxYxXElR9fATD9TfC6ecInwNuCFZJqioERPZtNgXtD53FymsyTVFWSB
         DNINjQ+wwZL05TVzhjHUGU/Uv9pgAb+l8o4k73QB7/CWg4YVKS0aQWsGZKpT/DGRn9Zu
         obrA==
X-Gm-Message-State: AOJu0YzoDg4PHlkL4BxjG7d8+nOKLvuENLOSNZobTsgqgAd0ChuadQPU
	RQl6Hvp2Qsasx0WX+v/dTgNjJsAk+O3lSKzt2vMFN2Ggml5v3t96wF2Cbw==
X-Google-Smtp-Source: AGHT+IGCavqwOgj7vni4GMfqykLmDVPuc/ExSTkhhVU7IYF+HpskCjVnqkfHAY+BBDQ9+/lvL1kECw==
X-Received: by 2002:a5d:5242:0:b0:360:9500:9bbb with SMTP id ffacd0b85a97d-362ff57d2c7mr831018f8f.12.1718742182737;
        Tue, 18 Jun 2024 13:23:02 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36245fc625dsm1969817f8f.115.2024.06.18.13.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:23:02 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-security][PATCH 2/2] README.md: fix sendemail.to value
Date: Tue, 18 Jun 2024 22:22:51 +0200
Message-ID: <20240618202251.1850637-2-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618202251.1850637-1-martin.jansa@gmail.com>
References: <20240618202251.1850637-1-martin.jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 18 Jun 2024 20:23:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/344

* other places were updated to use yocto-patches, but not this one
---
 README.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 3e092a9..6c24c2e 100644
--- a/README.md
+++ b/README.md
@@ -76,7 +76,7 @@ When sending single patches, please using something like:
 
 These values can be set as defaults for this repository:
 
-$ git config sendemail.to yocto@lists.yoctoproject.org
+$ git config sendemail.to yocto-patches@lists.yoctoproject.org
 $ git config format.subjectPrefix meta-security][PATCH
 
 Now you can just do 'git send-email origin/master' to send all local patches.
-- 
2.45.2


