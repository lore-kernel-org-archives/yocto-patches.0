Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D5EC3DA7F
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 09:02:05 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web10.32004.1721898122638903096
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Jul 2024 02:02:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=HnkQSjm8;
 spf=pass (domain: linaro.org, ip: 209.85.167.42, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52efd855adbso870641e87.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 02:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721898120; x=1722502920; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYfdn30CYY4FGMjXgpAAAXHsu3lcn9xCjA/L5LfGkS0=;
        b=HnkQSjm8bHfXF0T6wo1NnbkE/W3b6XwCUw8vp0SN7A+qiUB0uT9MXSHSTAOBceNVxJ
         AWb2BJ3cigudvYbRzUCmIwZYDuw0CcGZjmrn+6TLWNOAfPfWF91qmcVJchBhz2egUGwU
         LulglX0rBwsKRvcuYPSD5vd6zL1IftozPXa9ux5jyd4PEe9bNag7Io1Nb4qoI0YUfAw3
         1fdfxsON0k6VQQVLXaypqCrECNjNTLC5xL+L60B/XNi1F8QI83+DKW+e5pozpGBdIi4h
         7VMe2dciA2gP871RosoKtflXYRnpOcu04Qf8SdqSt+DXSz0EhlXOSPwuwSDCCuoYKC+U
         t58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721898120; x=1722502920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYfdn30CYY4FGMjXgpAAAXHsu3lcn9xCjA/L5LfGkS0=;
        b=BRtLgtsmQ5M6CA0sPdeRlTne9Gzw5LQJ95V8ZBwvTI4w4tENttibc6o/pagqfnIa0l
         RANwKHw1PbdS+YK2R5HII3dah63l6wLtRiL18Jz9onnHPYes65vCcAHOSJSw/InUM3kl
         YLTbQktLxakWTY9bpKdqIvnqqJHz0YFBc/tuCXLIBmgfMZiN9P+lUgs17GK/sIjteS3a
         B6vUQYWrAHodetXibuafM/45Yzz31YHlOPWtSFK1SaNpKT2YBgs89NgCHGzhi2Y7HRN0
         jeam2Frl5+82wGU6AJA4xSSaVqkCYC3knOH3+CiJUegyE6wBqkkn07XPKW1yKGdFbrmI
         rALg==
X-Gm-Message-State: AOJu0YziF2YVmygNc8sZypjjMKGS3QevOWrMZOTkd8/gdEBsuvvh/31Y
	BQF/Rw/QSeXi0Uy4I/H4xs7qvJ1HXj6ZnaV7SBQDPS734CJ9zBv67cxULg5T43IvPt4tBRd/by8
	l
X-Google-Smtp-Source: AGHT+IF9Km0FNrm3HIUZWuex/qg+iiazyG6gkE1OXraQzwrnXsv5wPnB5ByrHS8ci469yK6NsMez5A==
X-Received: by 2002:a05:6512:3d1d:b0:52e:9f17:841a with SMTP id 2adb3069b0e04-52fd3ef6e11mr1583120e87.6.1721898120352;
        Thu, 25 Jul 2024 02:02:00 -0700 (PDT)
Received: from localhost.localdomain (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c08d40sm152827e87.171.2024.07.25.02.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:01:59 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 02/17] python3-fail2ban: UNPACKDIR fix
Date: Thu, 25 Jul 2024 12:01:16 +0300
Message-ID: <20240725090131.75860-2-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725090131.75860-1-mikko.rapeli@linaro.org>
References: <20240725090131.75860-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 09:02:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/459

New poky uses UNPACKDIR instead of WORKDIR

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 .../recipes-security/fail2ban/python3-fail2ban_1.0.2.bb         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_1.0.2.bb b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_1.0.2.bb
index bf5f87d..757336a 100644
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_1.0.2.bb
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_1.0.2.bb
@@ -40,7 +40,7 @@ do_install:append () {
     rm  -f ${D}/${bindir}/fail2ban-python
     install -d ${D}/${sysconfdir}/fail2ban
     install -d ${D}/${sysconfdir}/init.d
-    install -m 0755 ${WORKDIR}/initd ${D}${sysconfdir}/init.d/fail2ban-server
+    install -m 0755 ${UNPACKDIR}/initd ${D}${sysconfdir}/init.d/fail2ban-server
 
     if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
         install -d ${D}${systemd_system_unitdir}
-- 
2.34.1


