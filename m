Return-Path: <mhalstead@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763AFCCFA05
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 21:57:22 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9725.1762466240675244537
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Nov 2025 13:57:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DKEuEcVf;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.216.54, mailfrom: mhalstead@linuxfoundation.org)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33b5a3e8ae2so82494a91.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 06 Nov 2025 13:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762466239; x=1763071039; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7i4cMX9hy6iql7VuzCcfk0Hk+BWMs20yST/BN4IECAY=;
        b=DKEuEcVftIqk2rJzS4tGmJCUjFMeyfQttKrzlr6hLMpfDKUHPDJFWaIY/yCbgGS8eP
         3HLzZVlIezcjSZarW83tQxyqT+HgmJscliHqatcmi0ao9T1Jq5Ym0cVUqP3OUQWr4TT/
         5xkTmFZ2naf88Rrqi9+tbkmgVIh9vEbAHlFpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762466239; x=1763071039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7i4cMX9hy6iql7VuzCcfk0Hk+BWMs20yST/BN4IECAY=;
        b=FNeX7tHsfGNe0espJ+FEU5/jEE1dLma2/5Hh/dHk3m5L8fd7uNsJdUXE8X6r009vOU
         XyBKXnYFb44f8NSnotbb9fkvSi/l0nChBEqzB29Bvcmz9oujZU8eIH0tiOP47OxEqnk1
         82o71pvPLws4WwMvlVdEPtJN0n5GoUWGGkMlCmnDrxRmKFqCQrv+gMwRYbWBzZac52Fa
         /b9YJuC1MJbHgXtz38UzcHNJPTOCrF2bPFTPa0wwtMybOV4Av0zfl2HzEhjYapg/ESMZ
         Hjk5cBLTzY8t9QPCqVivEIDOa7wIF9NYHvLtjLOKDQGz254vqlPQnIXmbhSXekSpjMET
         lifQ==
X-Gm-Message-State: AOJu0YyDTk/Mi4GXWjIfT/fudGxwRpS1Ji1iqdTXbVfx4psY/AFVBI50
	IXgCzjLyEW/+31on25kG58FXpTKtzETlkNjkxlQSEZ2pptGV3U0ajftIwBFSzCc3ixzsrMNcj0j
	nLQl7
X-Gm-Gg: ASbGncvP4Fky3ZzSKdkQBvsn/KRs00B7qaE/IIMntP7R68Lpk8nSQZiuDCgPOA8CANu
	GrE5oa3deck5kzYHZDOTE4sX16GfiHz/R3EcdiNJkS7w3kb1Tax7X20ISBbRIM+ZkF6bx3sLQB1
	8VCBX7k+FHsTOP8gHhbQ1HaqPw71e6F7dLIAJplN4dfjg3ppBziOGB5t2d5QHeEqoYEEJCvqMm0
	aoVT7Yj9zGwp73/TEXYlD8B8biDMLHLsJBuaQOhOC1AOI/RAaI9ANWaj50UNPrXPoNxrWN/Ybio
	nb5OrfEm/6rpJeUEBkD9Z4uBjyL7tK66jZVXSxYqX3mCT0yFW40OXEEr5+YvJ+vjY2Uj9G60vCO
	iUlQmoG2Mtf0S4RJn9CRVk7k7RSX+gZxTKti92xt6UIh7CfRaUsLkwNSw3zqQB52f+csr8N7k4+
	M8iw+k2wXYFZ+tWaH/+lM/HDGKVNS7iQV64udm2unPdj1NR0/lpTteiq3eswpHnQvZqms=
X-Google-Smtp-Source: AGHT+IEJCgDNI9XyHtF/oS9SjmPh0twW61oBmK3g2XBuhmNCUlyxU2crx4WH/gtDdM9ch1dgxTnzAQ==
X-Received: by 2002:a17:90b:1807:b0:340:b572:3b81 with SMTP id 98e67ed59e1d1-3434a1ef381mr1393264a91.11.1762466239298;
        Thu, 06 Nov 2025 13:57:19 -0800 (PST)
Received: from yoctolap.taild15c8.ts.net (static-23-234-80-56.cust.tzulo.com. [23.234.80.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a696dfcesm7291498a91.13.2025.11.06.13.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 13:57:18 -0800 (PST)
From: Michael Halstead <mhalstead@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Ryan Day <rday@linuxfoundation.org>
Subject: [PATCH][yocto-autobuilder2] config: add second debian13 worker
Date: Thu,  6 Nov 2025 13:56:39 -0800
Message-ID: <20251106215639.61883-2-mhalstead@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Nov 2025 21:57:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2425

From: Ryan Day <rday@linuxfoundation.org>

Continue upgrading Debian 11 workers.

---
 config.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.py b/config.py
index 82c1200..54331e5 100644
--- a/config.py
+++ b/config.py
@@ -165,7 +165,7 @@ web_port = 8010
 workers_ubuntu = ["ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1", "ubuntu2510-vk-1"]
 workers_centos = ["alma8-vk-1", "alma8-vk-2", "rocky8-vk-1", "alma9-vk-1", "alma9-vk-2", "stream9-vk-1", "rocky9-vk-1", "rocky9-vk-2", "rocky9-vk-3"]
 workers_fedora = ["fedora39-vk-1", "fedora39-vk-2", "fedora40-vk-1", "fedora40-vk-2", "fedora40-vk-3", "fedora40-vk-4", "fedora41-vk-1", "fedora42-vk-1"]
-workers_debian = ["debian11-vk-1", "debian11-vk-2", "debian11-vk-3", "debian12-vk-1", "debian12-vk-2", "debian12-vk-3", "debian12-vk-4", "debian12-vk-5", "debian12-vk-6", "debian12-vk-7", "debian12-vk-8", "debian12-vk-9", "debian13-vk-1"]
+workers_debian = ["debian11-vk-1", "debian11-vk-3", "debian12-vk-1", "debian12-vk-2", "debian12-vk-3", "debian12-vk-4", "debian12-vk-5", "debian12-vk-6", "debian12-vk-7", "debian12-vk-8", "debian12-vk-9", "debian13-vk-1","debian13-vk-2"]
 workers_opensuse = ["opensuse155-vk-1", "opensuse155-vk-2", "opensuse156-vk-1"]
 
 workers = workers_ubuntu + workers_centos + workers_fedora + workers_debian + workers_opensuse
-- 
2.47.3


