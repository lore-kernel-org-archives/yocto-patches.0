Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B73E7718D
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 14:06:12 +0000 (UTC)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
 by mx.groups.io with SMTP id smtpd.web11.152244.1734703567116885322
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Dec 2024 06:06:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=upbKBbVc;
 spf=pass (domain: linaro.org, ip: 209.85.208.169, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30037784fceso20987161fa.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 06:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734703565; x=1735308365; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2ELwFg/ftmP97Fy4F+z2lKTgOXcvCEH2i2t1Db9phs=;
        b=upbKBbVc0QQPBBOt41KmX1N3h1RcuJ7Dggbdw3Yy9H33mjqoN0Xudasxc5K8HqEOMk
         0i9w06PjOU5rWy5i9HLZJ/QfHn6/ta9iUSEV7Uo38nWw049DfWWKE7rk/NiOfPoaCpw5
         Wzfmr6Xe0qGHF7EWykFj3Abk1Cp/Rz8KytCaIjMr97vyQ+JojzbV+Azq5xiGsEek+1eC
         5gL/2VKZwBXuc/YbmxXVlXU40143h9fdusUK1xid16AehfsSFkOEIJNzyc/iAx/EYWgw
         Xmya/PcH3Tof3mdTYo2Nps+NzCHro7CnxdkfaRYpzeC/xFl5spejB3IjLl31tIvXV0ZE
         ATAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734703565; x=1735308365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2ELwFg/ftmP97Fy4F+z2lKTgOXcvCEH2i2t1Db9phs=;
        b=NUrWSMrFOC4Xh7loeE4mjjDyjkiL+X5SdQbYYsLkaobYg+YNUQMdUsjGfuy2ICyDlO
         nOdEzTvx2HXpoQskIhd2tL2VUtwbBsFF6UyOGLk/N2nJ0JJ8jKhQPIT3f4ko0BdjGj62
         q3GO69yMdr8/JUY/D8e/ZkGahZJN46wVE1ye4UvupLh2viXWH5X+dqmHpvfzdF8U7lux
         7X9rgEjhJNlh3Dmc+2ZrUeucOWjJqquqNAzn7uGViF/lqtw3pugJMiAv6diHCXLZ+WKr
         uBZDDkMfnIiExCzcy0GFwDBftyfMrNfzvW2+apN/diRS4sx3GPhu6vBsdBWgXk6l4nT4
         FEZw==
X-Gm-Message-State: AOJu0YzHcbgE7p7GCy+X/9St5Jvpb+J9Ym7rv6IwJjlxFfccWL+jYATN
	5o6XzajiuOifYJYubiJfm9qy4YCiJE00RxkZBjpVKYRpxHBXku9+mpwBk5sCuapoOjLsd/5WJqn
	GsPY=
X-Gm-Gg: ASbGncveTThtEku2hBxzujAZZ+4V5XT+vspN6g6mthGgCJW/wDPMP58MFY5TrCHWVQH
	YIk9A4xWz1oEM6vZNcZMKe7+WjijLrYkkoJq0mFBus40HvbhiNu8Y5xgprYHiMumlzLKxjczdQO
	rs+9v3SkkMz7Jq5zsoJ+/wmCX1rZ+32qYXENZLgKdN1srAa/GpxhP8jrXzJHyxK4luz6dcR3P9O
	jcoit3efNK6bIbboHeFO5jk7o9eF3iBr8KTyTpT50TCKM4R5xVZXqNeSqM2SRbX98kFZyVOpJZ8
	MZVhu5TaneXmJN5c0kKimv6wtw==
X-Google-Smtp-Source: AGHT+IEk+JA5kuXHh7aIJQ0u04dXXBKEQShwFjmhWxl8CVFtwYx8GBydQ2A3Wt1wYQuvLcVTJN4i9Q==
X-Received: by 2002:a2e:a591:0:b0:300:33b1:f0cc with SMTP id 38308e7fff4ca-3046861f5f2mr10815681fa.34.1734703565255;
        Fri, 20 Dec 2024 06:06:05 -0800 (PST)
Received: from localhost.localdomain (78-27-76-97.bb.dnainternet.fi. [78.27.76.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad6ca8fsm5227191fa.14.2024.12.20.06.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 06:06:03 -0800 (PST)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 17/18] oeqa runtime clamav.py: skip test_freshclam_download with systemd
Date: Fri, 20 Dec 2024 16:04:40 +0200
Message-ID: <20241220140441.271395-18-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220140441.271395-1-mikko.rapeli@linaro.org>
References: <20241220140441.271395-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 14:06:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/956

systemd service files already start a download at boot which locks
the files and thus the test fails. Instead of this test, with systemd
it is sufficient to check that all systemd services succeeded.

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 lib/oeqa/runtime/cases/clamav.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/oeqa/runtime/cases/clamav.py b/lib/oeqa/runtime/cases/clamav.py
index bcafc84..bd451ce 100644
--- a/lib/oeqa/runtime/cases/clamav.py
+++ b/lib/oeqa/runtime/cases/clamav.py
@@ -6,6 +6,7 @@ from tempfile import mkstemp
 from oeqa.runtime.case import OERuntimeTestCase
 from oeqa.core.decorator.depends import OETestDepends
 from oeqa.runtime.decorator.package import OEHasPackage
+from oeqa.core.decorator.data import skipIfFeature
 
 
 class ClamavTest(OERuntimeTestCase):
@@ -48,6 +49,7 @@ class ClamavTest(OERuntimeTestCase):
         self.assertEqual(status, 0, msg = msg)
 
     @OETestDepends(['clamav.ClamavTest.test_ping_clamav_net'])
+    @skipIfFeature('systemd','systemd in DISTRO_FEATURES means update job is already running')
     def test_freshclam_download(self):
         status, output = self.target.run('freshclam --show-progress')
         msg = ('freshclam : DB dowbload failed. '
-- 
2.43.0


