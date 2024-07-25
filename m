Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB37EC49EA1
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 09:02:25 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
 by mx.groups.io with SMTP id smtpd.web10.32015.1721898141140841327
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Jul 2024 02:02:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=sQ1MCtym;
 spf=pass (domain: linaro.org, ip: 209.85.167.44, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52efc60a6e6so871811e87.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 02:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721898139; x=1722502939; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cTPdgN6vFLZzUYmiV9ID/u60yG1ZIuiu0Nv4bXwPCk=;
        b=sQ1MCtym9zkk/zV13/0jb3qQZ6iZ2EideIDJN6/T6CLzxUoJO7/N8Sk1wjg4ut0WU6
         +N/oxXQtiD8jk7uNDzjp88Tp7gexTHjXzu/ixdDd1zLgXe+Eev0/LyhIO8mUpBjN5ES4
         aeobMetpI4nMrp3+6F8SZqx65LnUgs4toxg6TQOIWMhBGMcP2V/KKPplhXevD91xlcNF
         4FEy1JJDsdEJJlt4qZfZkqPRFSNkDPZCkKMg2GxI7AfTQMDfOBh1VmjBmXzQImhvdjR0
         iethhCJ8VgELGzBcKEc2W+0vdbR2cGJjgsMqGMP3LmZ61LDOheR8eTagPy/N0XTlJQgr
         z2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721898139; x=1722502939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cTPdgN6vFLZzUYmiV9ID/u60yG1ZIuiu0Nv4bXwPCk=;
        b=NhDPQyXMDim0l2FKlq90IOQZvjNstIPNZrruCpF5OqTLVbIECbYQ+4tarTpnODF4s3
         v6KOyqr8+Iz9nlc/rhGSauF3Ne/16K/MFPUIsICmmgTSB1YYk1lFJs+iehpZv7jpA8s1
         1cgYAHcLBBHQYDpyi/n0pqfSN/VRSHRP4D/d1zHwr0XsPJ95NHv7qNFxujZXKlcWdSbC
         9L7KCyKrwcXs1cLN/zb+7O0i82ACWYs1UOqJySTUqWlWkLtYrpQXGhT1e6Im1hyygZMa
         WUFrNyT2F1C6krMH9gkcZckT+KEUzdDGZsXLnqAcNTd3Q0AHZUU6zO3kyycPJ3u3QMdX
         nPcQ==
X-Gm-Message-State: AOJu0YxEgL2C0oArhB/xJRamPRGZ5CxWuNDDpSU8bjaGiybYnNUzJrVb
	I+59E+rLm1jCT5uSMPK076AVyA171vmYVIsi7RrWYI8VavcO5j3/wtjNp39QYsJ6VrMoH8Dxx9h
	H
X-Google-Smtp-Source: AGHT+IEi3Nr5y71YNUn1GE/vcZaYEAFQ+yypMOgEnNS8wDQR6Dqp+gSJFH5zJbCb8SoNMXIl8Gszvg==
X-Received: by 2002:a19:7403:0:b0:52e:f77b:bb58 with SMTP id 2adb3069b0e04-52fd6043befmr740469e87.36.1721898139405;
        Thu, 25 Jul 2024 02:02:19 -0700 (PDT)
Received: from localhost.localdomain (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c08d40sm152827e87.171.2024.07.25.02.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:02:18 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 13/17] arpwatch: disable compiler errors
Date: Thu, 25 Jul 2024 12:01:27 +0300
Message-ID: <20240725090131.75860-13-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725090131.75860-1-mikko.rapeli@linaro.org>
References: <20240725090131.75860-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 09:02:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/470

Old code throws new warnings and fails to compile.
Work around the issues.

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 recipes-scanners/arpwatch/arpwatch_3.3.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-scanners/arpwatch/arpwatch_3.3.bb b/recipes-scanners/arpwatch/arpwatch_3.3.bb
index cacfea7..a3f42f8 100644
--- a/recipes-scanners/arpwatch/arpwatch_3.3.bb
+++ b/recipes-scanners/arpwatch/arpwatch_3.3.bb
@@ -45,6 +45,8 @@ CONFIGUREOPTS = " --build=${BUILD_SYS} \
           --with-sendmail=${sbindir}/sendmail \
           "
 
+CFLAGS += "-Wno-error=implicit-int -Wno-error=implicit-function-declaration -Wno-error=unused-result"
+
 do_configure () {
     ${S}/configure ${CONFIGUREOPTS}
 }
-- 
2.34.1


