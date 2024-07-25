Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1906C3DA7E
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 09:02:15 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web10.32005.1721898125406340703
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Jul 2024 02:02:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=MKhPYSiO;
 spf=pass (domain: linaro.org, ip: 209.85.167.45, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52f01993090so795142e87.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 02:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721898123; x=1722502923; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02aSaDqJWRmjLqfFhoW70kGSC4/95HdhG8XC3RNq0mU=;
        b=MKhPYSiOJhXEWI/GMNqgS8OAdEcNOQp4c2Sv43DQp6Yg+mRivBtv7ivV4f3FW6LxhP
         Fcjr/T+UNSHuvQJgg4aSKzRv+DUTsLA64sTu5CzZMFjxm9eAfg3MSFJBaCInVNP6WLUE
         mkOevolvH1fR52P2uWrSvAdSWetg7Ta2PVPpizIDwxh3+JeA8d8Eo7uJk/kujstjIDoi
         HKaDq2/9kb4iw7eo1cyeYY6HryzNM+QAGTYhS+jh4G0PI0Nnj3f6AM8z4QszRse568Fc
         jCM53+I0ngRv72U/ERKoe+2dyGhSkW96DaJg3LKfIsUmt+PhDXJzIEZ5RL3beoLjKtrG
         FzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721898123; x=1722502923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02aSaDqJWRmjLqfFhoW70kGSC4/95HdhG8XC3RNq0mU=;
        b=I0fi0IqR5ETrbj8vT2AM2jJ/0Wu3z6sZ1hDqubDhJHAQKzA3DxKhlM8Hm4NQ5cDFJs
         g66naRzVIc51i+BcaH9H+OXw6baVOOvVatMhw5CKZGxWRxEv/cjla9JMhmbjfkkjPvYu
         9q+H9GH9ZkK/Pz3m4PMtSGSxxciDI2rPv6uzeEMvc3W6nLgF2zyo8pj92nrQtNZpTAEV
         0NOFPaVuqOenYgN9VavoNKVIpxLgZhikoyf7ESbpv9lx1p5ZIALTMG/1jXmLOjYKawAs
         RFFt8cHqjG89alB9T2htHbrzDNVyFE+HQ1M7RBQ9ZiGELpqRCSIIQkve75r42o6kXrx+
         vF7g==
X-Gm-Message-State: AOJu0Yy+alsZZaNEFttgakkPhf/vNyPwi84UN2mD+Hi7i0Lope9iSnka
	YPJWPhXRQEvgWwYhFvXfAJG9IEVJLiAzRD7dXg4+8/w9xSF37Zah/E9oORJ8ELcyqiGcQL63dHd
	8
X-Google-Smtp-Source: AGHT+IGmkBqtYGq9b8/j0A8e3ur3BrEKL8n8VKtNyEJHsZSh321XD2lWQ1gBoc83ipbdDv3zw4/tmA==
X-Received: by 2002:a19:f70d:0:b0:52c:e0fb:92c0 with SMTP id 2adb3069b0e04-52fd60439a8mr718406e87.34.1721898123504;
        Thu, 25 Jul 2024 02:02:03 -0700 (PDT)
Received: from localhost.localdomain (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c08d40sm152827e87.171.2024.07.25.02.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:02:02 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 03/17] initscripts: UNPACKDIR fixes
Date: Thu, 25 Jul 2024 12:01:17 +0300
Message-ID: <20240725090131.75860-3-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725090131.75860-1-mikko.rapeli@linaro.org>
References: <20240725090131.75860-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 09:02:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/460

New poky uses UNPACKDIR instead of WORKDIR

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 .../recipes-core/initscripts/initscripts_1.0.bbappend           | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-hardening/recipes-core/initscripts/initscripts_1.0.bbappend b/meta-hardening/recipes-core/initscripts/initscripts_1.0.bbappend
index 92e364c..8af6979 100644
--- a/meta-hardening/recipes-core/initscripts/initscripts_1.0.bbappend
+++ b/meta-hardening/recipes-core/initscripts/initscripts_1.0.bbappend
@@ -4,5 +4,5 @@ SRC_URI:append:harden = " file://mountall.sh"
 
 do_install:append:harden() {
     install -d ${D}${sysconfdir}/init.d
-    install -m 0755 ${WORKDIR}/mountall.sh ${D}${sysconfdir}/init.d
+    install -m 0755 ${UNPACKDIR}/mountall.sh ${D}${sysconfdir}/init.d
 }
-- 
2.34.1


