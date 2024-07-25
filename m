Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A88C3DA5D
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 09:02:36 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web11.32100.1721898147235610195
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Jul 2024 02:02:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=w5pf8tXu;
 spf=pass (domain: linaro.org, ip: 209.85.167.54, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52efbb55d24so927512e87.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 02:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721898145; x=1722502945; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nzr9Qna32F7ErKbsME+2VHMIaB+4JetoXDnifOC5WdM=;
        b=w5pf8tXuTL9sbHIdpQ7+B+FUaoZGPHYKn4wKRbA2juZgxvqifg9gZ+kwEWbwXi5ETb
         X/ICRPmbSsz1BcN6PZfFXTlc2qFHB99RpKV25G5/TKJmPJnue4hJgeIjhr/oeKCMW3cw
         ldRFXDGEjcvasVUP9Kw49PiW/BcDnHij5BKqJ4aAF+v/51FT7Xt4v1WfEtSYrg+Feglr
         fbgSgAdzDLy2jJaCES4NIrHvPAqYoqb7JyXLU0+uaMMqlu0YClrbdfHu84iTEjgqG+gr
         EB+rWoDCLcZu3NJe0HL759L2NmU0xoWLk/nrjDpEXDhSqyOclKihmkkVqZBxcOx5slNH
         kOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721898145; x=1722502945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nzr9Qna32F7ErKbsME+2VHMIaB+4JetoXDnifOC5WdM=;
        b=GFaSMRtSelVxxWz4FM7Ddd/KqB3FMEC0dkxBgHYrR3Vm6L8svvFoJSLkN0E5E3lz4U
         NOxdk0EmMegf731W54K/YaE6Uevx+ByeUrMi03GvAr9EbwBKpjiAmMMm1hzgNEwKJN05
         6fk4GiH5W/dV/LZDQHlEs57Dh6xOiS2SyvUl3Fw7ucIegLKtyAFmq9Tr1e0aYcP0vdkT
         zg6J/l3F4XxC3ku/ThH9ymh4LSKk1qrv1oxpQ5nvQ2jwkt+XPfXivZmXU/+fx8ojjfT2
         gRSC+1NbpGsZIR85rT/GLSRGT7drb90/RBZoOn5zlS4uEMwY9fO3CR21JQaDQCzn9/gt
         XEzg==
X-Gm-Message-State: AOJu0YyXgFGx5lJ/b6F0Hy57BdtR/SJStykZjS1A+R42qu1nOO9xr6sj
	qfvAnSsQPRZ98YWOGU15sanj7yKER9aOS4d4ZQ2NBgGUHazeoGnxpzaMl7SnNmzN1ljlNaibe5a
	H
X-Google-Smtp-Source: AGHT+IF/AEcSaPlqAdDQpe3yXRC8CtZXk8pTEpvgpXX5GEhWwGn2NjH2EfcUZbPGrsNKuJ8NMVnmeQ==
X-Received: by 2002:ac2:4bc8:0:b0:52c:d76f:4604 with SMTP id 2adb3069b0e04-52fd608390amr1296378e87.46.1721898145462;
        Thu, 25 Jul 2024 02:02:25 -0700 (PDT)
Received: from localhost.localdomain (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c08d40sm152827e87.171.2024.07.25.02.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:02:24 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 17/17] suricata: remove build paths
Date: Thu, 25 Jul 2024 12:01:31 +0300
Message-ID: <20240725090131.75860-17-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725090131.75860-1-mikko.rapeli@linaro.org>
References: <20240725090131.75860-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 09:02:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/474

Remove build time tool paths from build info
which gets embedded into binaries.

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 ...uricata-remove-paths-from-build-info.patch | 56 +++++++++++++++++++
 recipes-ids/suricata/suricata_7.0.0.bb        |  1 +
 2 files changed, 57 insertions(+)
 create mode 100644 recipes-ids/suricata/files/0001-suricata-remove-paths-from-build-info.patch

diff --git a/recipes-ids/suricata/files/0001-suricata-remove-paths-from-build-info.patch b/recipes-ids/suricata/files/0001-suricata-remove-paths-from-build-info.patch
new file mode 100644
index 0000000..ebd1433
--- /dev/null
+++ b/recipes-ids/suricata/files/0001-suricata-remove-paths-from-build-info.patch
@@ -0,0 +1,56 @@
+From 3d11a6a8c764e4af2f24cc4cf56b4943a3aa212a Mon Sep 17 00:00:00 2001
+From: Mikko Rapeli <mikko.rapeli@linaro.org>
+Date: Thu, 25 Jul 2024 08:31:21 +0000
+Subject: [PATCH] suricata: remove paths from build info
+
+Remove paths etc from build info to fix build reproduction
+issues.
+
+Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
+---
+ configure.ac | 12 ++++++------
+ 1 file changed, 6 insertions(+), 6 deletions(-)
+
+Upstream-Status: Inappropriate [configuration]
+
+diff --git a/configure.ac b/configure.ac
+index 5258f3d..9712c9b 100644
+--- a/configure.ac
++++ b/configure.ac
+@@ -2632,13 +2632,13 @@ SURICATA_BUILD_CONF="Suricata Configuration:
+ 
+   Rust support:                            ${enable_rust}
+   Rust strict mode:                        ${enable_rust_strict}
+-  Rust compiler path:                      ${RUSTC}
++  Rust compiler path:                      
+   Rust compiler version:                   ${rust_compiler_version}
+-  Cargo path:                              ${CARGO}
++  Cargo path:                              
+   Cargo version:                           ${cargo_version_output}
+ 
+   Python support:                          ${enable_python}
+-  Python path:                             ${python_path}
++  Python path:                             
+   Install suricatactl:                     ${install_suricatactl}
+   Install suricatasc:                      ${install_suricatactl}
+   Install suricata-update:                 ${install_suricata_update}${install_suricata_update_reason}
+@@ -2667,13 +2667,13 @@ Generic build parameters:
+   --localstatedir                          ${CONFIGURE_LOCALSTATEDIR}
+   --datarootdir                            ${CONFIGURE_DATAROOTDIR}
+ 
+-  Host:                                    ${host}
+-  Compiler:                                ${CC} (exec name) / ${compiler} (real)
++  Host:                                    
++  Compiler:                                
+   GCC Protect enabled:                     ${enable_gccprotect}
+   GCC march native enabled:                ${enable_gccmarch_native}
+   GCC Profile enabled:                     ${enable_gccprofile}
+   Position Independent Executable enabled: ${enable_pie}
+-  CFLAGS                                   ${CFLAGS}
++  CFLAGS                                   
+   PCAP_CFLAGS                              ${PCAP_CFLAGS}
+   SECCFLAGS                                ${SECCFLAGS}"
+ 
+-- 
+2.34.1
+
diff --git a/recipes-ids/suricata/suricata_7.0.0.bb b/recipes-ids/suricata/suricata_7.0.0.bb
index d87cebd..35ac8c0 100644
--- a/recipes-ids/suricata/suricata_7.0.0.bb
+++ b/recipes-ids/suricata/suricata_7.0.0.bb
@@ -10,6 +10,7 @@ SRC_URI[sha256sum] = "7bcd1313118366451465dc3f8385a3f6aadd084ffe44dd257dda810586
 DEPENDS = "lz4 libhtp"
 
 SRC_URI += " \
+    file://0001-suricata-remove-paths-from-build-info.patch \
     file://volatiles.03_suricata \
     file://tmpfiles.suricata \
     file://suricata.yaml \
-- 
2.34.1


