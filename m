Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E40E77188
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 14:05:22 +0000 (UTC)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
 by mx.groups.io with SMTP id smtpd.web11.152222.1734703519021722221
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Dec 2024 06:05:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=QiIAiHwg;
 spf=pass (domain: linaro.org, ip: 209.85.208.169, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3022484d4e4so21659011fa.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 06:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734703517; x=1735308317; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/msncIn+QRVtskCgKtqv4gFMsSgtlIaOLRE5sydyDk=;
        b=QiIAiHwg8MNDRVONmSmVely7Y7Hwh4zQeuAnkxbKJhFJWP7siw0VWsPiDRn+Uqoasx
         qHqEaYi+RHpm6aFyulv8vgzsqiO6UIq6BVHuqArMn9K3gLF0dWcvL5Y8QYfK5Lmix7ez
         +mAy6n5yfO5Q+vL52DWxq2FWkvTlOYT2/pBtsZ8SZ36aBM97oSYzmtVkLvVxp8952PR2
         qeSVfBJGOUpi+EvHG40V9MibnUXZoY9n4HDpjbJqE6nLXriVQ4kkBVUxJvbGVguDjnpx
         iwuqPOvJEGBKwss/GU+QgEqUq7evNsPQw/w6cKtqB6RGBXuQ+0AWFfVWIsxll2zOxmh+
         5qBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734703517; x=1735308317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/msncIn+QRVtskCgKtqv4gFMsSgtlIaOLRE5sydyDk=;
        b=OJlWa4dRC3v6NT3OciJ+FsTfRD37C/CaISFV2nMDYNOXCFFbyj3V7NPEtQa2AdUOnP
         ZifDe8Jv+kM46opQ2BaTYAN9hr+fksHPrTjFSORJanG5PYH2GeThRW1856PCESb8aaC2
         EQnkKrnASmp3SlbRZ5RtP2mcuWc2wiaerWO2S3JWKVk8VpXRj92PiLSdb/1q+/BZtgFi
         XFmDH3/6N/fKTZmi22rXAilHXV8eoJxzPHenU08JOHA7LK7NprTwKgxbpw7Vwjn7BX1S
         1vRl571kMHxrNzQTnSptUV+Cw2BsCB+Iumkw5+4YbiMifaT4X5NOy5KgApCifP+FJ51w
         yZ9Q==
X-Gm-Message-State: AOJu0YyHPUBYCRgWKPXvyIBt3e+mdae0idolTKE8Zye9wN7XEh2jAGe3
	SjNu+XFfdv+NIbXLi2StV1oTz63HjZWMUl/fgUs8zzVvzI2Wmjm6FTByTihg2BfnSP87Pcyy4dy
	ShrQ=
X-Gm-Gg: ASbGncvUeC4+Tf3kxzQKx4bUVLzp+chqorKBweta3BYmZmsMREs8SVo46rqKzCy8eZy
	oaQVcnJ+hBLwohVbdH3Zk916WvJztyDvH7+TOmuVSy+xnny2yxlITWBuiRCHq5+V6ZSr9jFrFJV
	t/oDSLe+7LmTPFIIl3nvtOkCr0CPYCQ/58qAyQnZmL3qBGhiOvFEQqRqmrXhfdL5k/uo954BC9O
	ORL6ogLIm40qmQLqDPRT2uB12GRIM0uz/jxf+971Dzy6CIXstpkcRBM3dr2stwcrl9dMcUtqwrv
	LFUlvf/i/e+y3j7ACKEZsctoaQ==
X-Google-Smtp-Source: AGHT+IG5QiB8Kt4rw248WxsMA3O6i+bzY4hRXNvAyjO9xh3FrKO71Z5q2a1fru0Zf0NXi4dLD9nWjg==
X-Received: by 2002:a2e:b888:0:b0:301:12:1ed6 with SMTP id 38308e7fff4ca-30468545dc2mr11203851fa.11.1734703516870;
        Fri, 20 Dec 2024 06:05:16 -0800 (PST)
Received: from localhost.localdomain (78-27-76-97.bb.dnainternet.fi. [78.27.76.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad6ca8fsm5227191fa.14.2024.12.20.06.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 06:05:15 -0800 (PST)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 05/18] oeqa runtime clamav.py: use curl if ping fails
Date: Fri, 20 Dec 2024 16:04:28 +0200
Message-ID: <20241220140441.271395-6-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220140441.271395-1-mikko.rapeli@linaro.org>
References: <20241220140441.271395-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 14:05:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/944

TEST_RUNQEMUPARAMS = "slirp" does not pass ping through
but UDP and TCP will work. Thus curl the http website
even if the response is DoS blocker and not the real
website.

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 lib/oeqa/runtime/cases/clamav.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/oeqa/runtime/cases/clamav.py b/lib/oeqa/runtime/cases/clamav.py
index e0cad8f..bcafc84 100644
--- a/lib/oeqa/runtime/cases/clamav.py
+++ b/lib/oeqa/runtime/cases/clamav.py
@@ -43,7 +43,7 @@ class ClamavTest(OERuntimeTestCase):
         msg = 'File could not be copied. Output: %s' % output
         self.assertEqual(status, 0, msg=msg)
 
-        status, output = self.target.run('ping -c 1 database.clamav.net')
+        status, output = self.target.run('ping -c 1 database.clamav.net || curl http://database.clamav.net')
         msg = ('ping database.clamav.net failed: output is:\n%s' % output)
         self.assertEqual(status, 0, msg = msg)
 
-- 
2.43.0


