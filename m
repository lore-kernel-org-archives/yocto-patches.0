Return-Path: <omri.sarig13@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DBFC28B30
	for <webhook@archiver.kernel.org>; Tue, 11 Mar 2025 10:34:30 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web11.5723.1741689263239146026
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Mar 2025 03:34:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=i7H6FH4/;
 spf=pass (domain: gmail.com, ip: 209.85.208.173, mailfrom: omri.sarig13@gmail.com)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30797730cbdso55966341fa.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Mar 2025 03:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741689261; x=1742294061; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYokqhiuf6XaVjTzpRxsNCGZoDFaBpezR/c+jNdVSWI=;
        b=i7H6FH4/k7rG6h6WVF9tGSJttiNzBCl1rfEM9dx3bnX962Zt23JSrw78xgyTkSEQGh
         HBcWc2kqHQICgLnC1U52jUtLeY36bOhu1nvv56nRblxIYYZoIBnXaqdKKx1xos5iMkPe
         zbb6YvtroIUMbqOObkAvSb/Jp19YWtKDqGT+3KbtuLaNlTo+ifLZ2DEVQy/KHQsILAmM
         Av0v3gkgwDNxVelVsC67mQZYbaz7UrfpDonnDIegtl8pem4jiOlXh86kVAGGXVA8KLEv
         WU/rQrnPt35Pcrfi3WRwEhJdfhx57QIXv+mTuqaRynh85/DRPhSB1M6yYZT4QXEleSeo
         a2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741689261; x=1742294061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYokqhiuf6XaVjTzpRxsNCGZoDFaBpezR/c+jNdVSWI=;
        b=h/PQ0bWLNuG2oKCLKekdjbi9z5RTLo3NWnLKiljtAWhC7WIEQsb1rz8R9tz7kPQwTQ
         DnufyJE2Q0O/GuFRkGrBBFptgGWzWwD78Mudnd5LN6Whv2/g2qPUdtTSuuuDuIagRwb7
         lvsJs5qJu5T0e/R7JAt74Y+1cR43L3Oidq93ja0qKiVEA0QwzUD15kk1GcBjAef4ctAU
         4vitgOQq5wl5WaoA4k7w0hJ2z5cZr2roYMV94SFSdhoZYhoyxZXbQ7F0mEBEHziZlW8+
         BJcQwJTnObZbG0lGLX1CcTxGDrrcD0/cerLS8j1OkJDC7Va3IZT2owsyfOT6R6WFssoA
         oiug==
X-Gm-Message-State: AOJu0YyWz0/1vaf+vfBDTAI/7lc3OP3GlBTjPHJPqXUuCt7hR9Ote+Wt
	ZLT1CqybL+miZRvlzrehauu1lmXEYe7QvSdQIO2ST9aOYje/LHF4beDOadhv
X-Gm-Gg: ASbGncuMQblxF4GmkBLN8FDGSxG9xmMtV1nIVY0KtXZSYoqOxYRMKu7t0+HX6vjLHkN
	enmnu67sAplJlWi8AOn97p4KYWTvCjUSnN/dk8Y/qagySX+iosAraCMZZ1U2xeOjtpScTVWTyDW
	qqQWJcTrYMqx8ZTbOIvmNQ/owaIEst24xizYOZSp9zcK4207xl6kFfPjO+Ygd96EPbOs8fzE8g7
	irQrKvLd+FiLlPjRoL1qKs6KJ5fpvSidb1JXCjTJGPCo5PvwFtGVtwqIHZ7wE6kmhz6udJ6w/Dt
	oNNZOtSKDQJS91QHg0tqP6uQ302B1eKL8CKP1+JPiM8PucaK7inrp6CU8coCqg7iCRKOU3OSJ8J
	frZ/KnDyw/qrzS6vkfuMApVFiWMI=
X-Google-Smtp-Source: AGHT+IGyrwuCb5PmK8u6eOFhykcKkcVJximuvuIm5Iq1I9TU3hUUFkqGL88w3vLEBgROljt0STaAAQ==
X-Received: by 2002:a2e:8905:0:b0:30b:f15f:1baa with SMTP id 38308e7fff4ca-30bf4639c43mr58474291fa.32.1741689260599;
        Tue, 11 Mar 2025 03:34:20 -0700 (PDT)
Received: from omsa-HP-EliteBook-840-14-inch-G9-Notebook-PC.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c0ed155f0sm9080431fa.28.2025.03.11.03.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 03:34:20 -0700 (PDT)
From: Omri Sarig <omri.sarig13@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Omri Sarig <omri.sarig13@gmail.com>
Subject: [PATCH 2/2] tpm2-pkcs11: Add tools python runtime dependencies
Date: Tue, 11 Mar 2025 11:33:33 +0100
Message-ID: <20250311103333.2972573-3-omri.sarig13@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311103333.2972573-1-omri.sarig13@gmail.com>
References: <20250311103333.2972573-1-omri.sarig13@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Mar 2025 10:34:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1179

The tpm2-pkcs11-tools python module is importing several modules which
are not currently included in it's dependencies. This causes the script
invocation to fail. The current commit adds the relevant dependencies,
to ensure that the python module is always able to run.

The relevant dependencies are:
* python3-fcntl: To add the fcntl module, imported in db.py.
* python3-sqlite3: To add the sqlite3 module, imported in db.py.
* python3-tpm2-pytss: To add the tpm2_pytss module, imported in
  utils.py.
* python3-compression: To add the zipfile module, imported through
  "importlib.metadata import distribution" in tpm2_ptool.

Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
---
 meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb b/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb
index a7d8170..331dc4f 100644
--- a/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb
@@ -44,6 +44,6 @@ FILES:${PN} += "\
 INSANE_SKIP:${PN}   += "dev-so"
 
 RDEPENDS:${PN} = "p11-kit tpm2-tools "
-RDEPENDS:${PN}-tools = "python3-pyyaml python3-cryptography python3-pyasn1-modules"
+RDEPENDS:${PN}-tools = "python3-pyyaml python3-cryptography python3-pyasn1-modules python3-compression python3-fcntl python3-sqlite3 python3-tpm2-pytss"
 
 BBCLASSEXTEND = "native nativesdk"

