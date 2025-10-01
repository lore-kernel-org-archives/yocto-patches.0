Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC37CCA470
	for <webhook@archiver.kernel.org>; Wed,  1 Oct 2025 12:10:52 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web10.15727.1759320644457644367
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Oct 2025 05:10:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=diJdOvfr;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42557c5cedcso552368f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Oct 2025 05:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759320642; x=1759925442; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BeMiPNG/3NqblVlOgpaWOymj4mRA6g/lIhrIyET6PgQ=;
        b=diJdOvfrJFw6jhWRdmcJGAw0M9BbuXCUiMCKlAxdqjMYg8G+UFe/ojI5RI5dcKNg3Y
         MlnwEOrvnynzFkSrUN51PPqqlEnSxfCmS45MyW0ikZbs07p/XvhHQTCV7I0nb3pZXVRm
         BoqOikkkT7sp5qsiA3Tu3DulId+rmFZc5k4cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759320642; x=1759925442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BeMiPNG/3NqblVlOgpaWOymj4mRA6g/lIhrIyET6PgQ=;
        b=KtuiwkwyRp/rct6PviplzdRwqF3f+3sFWo07KRoNFNIMFqyo4ubeCk0RFScTd8Wd6H
         KE/Wh9CQWfXbbsNoICi6VkLUmNCKRm7a7CLzZVwIgGJ1UtB5/aOm7GrlAGGK8CFAH2b2
         nkwSCQZNDksBLh6Ko6JrBy/a6Xh3DihR6kRHJpnnt3kWkbtaeYwX91nH1959pmIlPuKx
         53lJGSUByp3jYUSa8ZgKB+17Upkx2XvTpCVB78vbV9kBgwq6TA5LtXWTqobMnkjQmu1H
         XkGjV9pIW7GPiTevZQnNnO4h1PJX0umR6g03qdfjcCkEzjNalVrYv7QqhgW7ouos8Jwq
         g1/w==
X-Gm-Message-State: AOJu0YwleFYk59umrD5TLXPj0pQTMPs1+BUPvhUL6Rk/XRuFu3XC+udh
	vlcahVlUR/uHQyI8G/rvBSUzuDrochcJhGfnePPbe5uj07392bxd9ATgkp3c4gJt5t7EDX6WO6q
	h2PmN
X-Gm-Gg: ASbGnctOOBc+JqfSA93eeNhrs7R4TpW71vTFvw07+JwwrPpbS//KQ9vkyHLxbt0J6mK
	Wgme07Ur/hAydcrASR1bQeMMT268EdNjVEjwI6sz9DTZM+AU701vDdux1kwRPOZ0VP+lH9q7LG5
	Wx8kw+cdI/zwfUi1q07N6vSyTSBATPgwoDm9zROfyzaPnA01s1QkfcJwvCUb3FUkbIpIIA9fVns
	VK/IkR9xvXy7WMtK+886YOQwRa8j6IsmOlGI+SgZD90bR+RKWIYwnIpIC8DY4F943AfWfXUiGTR
	R5yuqhDtB8epPlVpdidGtraEEc51BWJJPZokExEqroaWzU+IdtEjnP+4YLuN4XDsVDjAtB3vory
	L5gwu0k93Lu2T6pQmvvQKJM20076PQ4lGNcHJ/fdlU4GzFy82snriTEAg3iB9qtGiK4+2OF+kZ1
	Q=
X-Google-Smtp-Source: AGHT+IEBiS2Ck0jTxzc1AUFglO4KPdvYqGWzVYDsw9UHjZsak5yactYl9q9Rti4rjtYeHH4inxW9rA==
X-Received: by 2002:a05:6000:310d:b0:3fd:bf1d:15d1 with SMTP id ffacd0b85a97d-4255781b921mr2170181f8f.49.1759320642094;
        Wed, 01 Oct 2025 05:10:42 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:d53b:59af:db6b:d4f7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5b56c792sm35300705e9.0.2025.10.01.05.10.41
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 05:10:41 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH] config.py: Add debian13 arm worker
Date: Wed,  1 Oct 2025 13:10:40 +0100
Message-ID: <20251001121040.254748-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Oct 2025 12:10:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2267

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.py b/config.py
index 991ac6ce..ac8ab2cf 100644
--- a/config.py
+++ b/config.py
@@ -173,7 +173,7 @@ workers = workers_ubuntu + workers_centos + workers_fedora + workers_debian + wo
 workers_bringup = []
 # workers with wine on them for meta-mingw
 workers_wine = ["ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1"]
-workers_arm = ["ubuntu2204-vk-arm1", "ubuntu2204-vk-arm2", "ubuntu2404-vk-arm1", "ubuntu2404-vk-arm2", "ubuntu2504-vk-arm1"]
+workers_arm = ["debian13-vk-arm1", "ubuntu2204-vk-arm1", "ubuntu2204-vk-arm2", "ubuntu2404-vk-arm1", "ubuntu2404-vk-arm2", "ubuntu2504-vk-arm1"]
 workers_buildperf = ["perf-debian12-vk", "perf-alma8-vk"]
 # workers which don't need buildtools for AUH and are able to send email to mailing lists
 workers_auh = ["alma8-vk-1", "alma8-vk-2", "rocky8-vk-1"]

