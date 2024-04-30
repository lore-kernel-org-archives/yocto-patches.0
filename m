Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19458C41513
	for <webhook@archiver.kernel.org>; Tue, 30 Apr 2024 20:33:53 +0000 (UTC)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
 by mx.groups.io with SMTP id smtpd.web11.26387.1714509228074844949
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 30 Apr 2024 13:33:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=VP4lSrVw;
 spf=pass (domain: konsulko.com, ip: 209.85.161.45, mailfrom: tim.orling@konsulko.com)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5afbd1c3ffeso1009634eaf.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 30 Apr 2024 13:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1714509226; x=1715114026; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pj//6M3s+JTLGm7FjiRimk3y3dNcu0tJXLsoS10YveA=;
        b=VP4lSrVwH3E6R1t4rU5vRiYtaF25fFfASEDZOygx9CV7YRK/BQHe8IkX9nhcRoqg9x
         n9M0DLnNQzQ+o3omw25s5wVGXt2tMrCi3I3U8QwB3cS0bnhQiQV1OdAqo4yVdBHhQHT1
         C0k7Y5/dAShZXUzzZ45ntg8gSGBr41y+GIPyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714509226; x=1715114026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pj//6M3s+JTLGm7FjiRimk3y3dNcu0tJXLsoS10YveA=;
        b=Sk76yJFo+gwfrUMSsod4Ejl+q11VilxTK23Nl3F2t+q3QXeAgPstlACcF4nvCrjo50
         orVYOR7OqBKO6fBmLvnl8FDbqXJx6taTwbS7v2wmRD8b2zn47xhwnLzfDpFFZtddDOAS
         Hr7xOoflRL19+kMy1hBDN+CGcZPId9BU6THYDuRM86WBQYPldmRNa4Ep/Gl5VCz0ddJu
         82a/3Lwgpc0xc04lWmrJOs4zlbBcxha9VsYBN1Khxfl/J7QBPx8vk3Npc7PF55ipPyg1
         1jynwBMugylAXYlrV/tg9RRXgPg0HuHZao0LID0yXLd8H4LKeYRNxRhgF0a15rG1rVta
         V5Hg==
X-Gm-Message-State: AOJu0YxLpsV8i44InUpSwWcNGV8b+9YI8fEa5XVLh7Td6/+MmWIEfR1z
	t2MLmMIEcKnDrNeBvSkAOmbyrvr3Sqet0hb8xKdoaJYhzfJETbL2hgLQCqiUqWC/IrRTef5qX2g
	wpns=
X-Google-Smtp-Source: AGHT+IEG1ie3XzTlrhHs7t3V++eWX0gy7D9chcUlFEu+Xu/DQUm2OO6kU4pkkgiNzmjljCfjXaeATg==
X-Received: by 2002:a05:6359:410e:b0:18e:a0ce:a35c with SMTP id kh14-20020a056359410e00b0018ea0cea35cmr1180370rwc.14.1714509226377;
        Tue, 30 Apr 2024 13:33:46 -0700 (PDT)
Received: from localhost ([2601:1c0:ca00:bd60:e8c5:20ec:b8be:259c])
        by smtp.gmail.com with ESMTPSA id x1-20020a63b201000000b005e838b99c96sm21372746pge.80.2024.04.30.13.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 13:33:45 -0700 (PDT)
From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [meta-security][PATCH 3/4] libtpm: BBCLASSEXTEND nativesdk
Date: Tue, 30 Apr 2024 13:33:34 -0700
Message-ID: <20240430203335.110707-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240430203335.110707-1-tim.orling@konsulko.com>
References: <20240430203335.110707-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Apr 2024 20:33:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/77

nativesdk-swtpm needs nativesdk-libtpm

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 meta-tpm/recipes-tpm/libtpm/libtpm_0.9.6.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-tpm/recipes-tpm/libtpm/libtpm_0.9.6.bb b/meta-tpm/recipes-tpm/libtpm/libtpm_0.9.6.bb
index a860319..cd47155 100644
--- a/meta-tpm/recipes-tpm/libtpm/libtpm_0.9.6.bb
+++ b/meta-tpm/recipes-tpm/libtpm/libtpm_0.9.6.bb
@@ -13,4 +13,4 @@ inherit autotools-brokensep pkgconfig perlnative
 PACKAGECONFIG ?= "openssl"
 PACKAGECONFIG[openssl] = "--with-openssl, --without-openssl, openssl"
 
-BBCLASSEXTEND = "native"
+BBCLASSEXTEND = "native nativesdk"
-- 
2.43.2


