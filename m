Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3CCC35FFA
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 19:59:19 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.4143.1742414351856538566
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Mar 2025 12:59:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Ta9yFYtt;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so157545e9.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 19 Mar 2025 12:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742414350; x=1743019150; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SOCKnWaiIofwgniL8tj4LLIy8fCGTTqTvSGfYUEOctM=;
        b=Ta9yFYtthscRCz5Q8Sipt47fTG0kh7t0N13jraNc1m7LsA/A713zoxzxedFX/N2+Ss
         cWWfSguH1soRPjZNZaTN7ohWEUdFfl2X/APgzQvc0aY8maapyCig6ofDukHj1akDcOk8
         TG8wy0ohfrGz/qaCMdnEXz3CRoWoBfa8772MI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742414350; x=1743019150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SOCKnWaiIofwgniL8tj4LLIy8fCGTTqTvSGfYUEOctM=;
        b=XyyqPQVyiD+gfgnLHUuCmVSvrbMrAG9nChQnIMylQeSKwQFq3QR2OY+LT2yYDkDQ9V
         joHk+6r2JvOBGf9ikfnlhRiVXd2wvgArg/D3OuVV9FXK5rY4gfwxsqkHOoyjque7D4Mu
         RVuy6h1kHKmvJPGwl6O8gviAFe5GS0bZ3GCIjcKqX/EMJ2PuB2CHSEEXByWPTtz9/Tit
         pnu84ErIvxVad7hhB4SB/bEAoAyqLnfzQb7/MCMuTXJNRJt1oYSdmVlG+9U3xHDlN3e/
         C19v4Cv+jbJhBhVosLvTu1JJTjmMxl0LQogWUQZ1Hw+OK13jWVOSE2G05pK979sVpIE8
         NXWg==
X-Gm-Message-State: AOJu0YxN6+AVrnfHE2eert9rkDaOOELtxrH88LQCJhEzhDuTMNH0jpn7
	30v3v+aqVxOv5BW87hfzpXU4v4qZ1ZUnpTDBw74i7j6tQGh6/DuGHWNAp5JKqhegP8LDIgoZnNI
	L
X-Gm-Gg: ASbGncuCoP249QxLWNFcp7pnD4DFteRFQYYhopnLJinFndwDrk3RK8DX6wKngACOxDi
	84vQmH8uvIvOeI1BL1ygMEMtw40rGUqXfz41itsEgoz/em5Ed26I1X+FZHeC/D7qWAd6/Rpibys
	JexYBu/48hwjzsd4LGSYXzhhH4581D8GXVdAV67q8gskNjsBRb9+cNtJ8cr1ZHo7VZ+/1Ss0ntT
	/Bpo207yEeKGIJiUEsoWSxBD2j3X61I7OK+yh7D1aI8Cay6XxyRE+tppKd8BtoXTS3OfwQSovIf
	j0xkzCq+iaCosJ4W/cjkuaAl8vU1rVxTMMOVHxcY+VkOt99mgcx1i2g7CQKE5Fmkqyusa3nLU8Q
	pG6SZey8=
X-Google-Smtp-Source: AGHT+IFpAC3gz59JlIzXDB5Kxx2zBtpWKV/vviX2KDz7z2UPTDm2mrQ+5k6R1YYY6hV7hOegLdhm5Q==
X-Received: by 2002:a05:600c:1e07:b0:43d:b85:1831 with SMTP id 5b1f17b1804b1-43d436c7be6mr40840215e9.0.1742414349819;
        Wed, 19 Mar 2025 12:59:09 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:dad:b471:9c34:4577])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f84f9bsm27584415e9.33.2025.03.19.12.59.07
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 12:59:08 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Drop obsolete ubuntu1804-arm buildtools entry
Date: Wed, 19 Mar 2025 19:59:07 +0000
Message-ID: <20250319195907.860738-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Mar 2025 19:59:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1227

This is was for the old cluster which is now decommissioned.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.json b/config.json
index b8083c4..9aafa5a 100644
--- a/config.json
+++ b/config.json
@@ -1981,7 +1981,6 @@
         }
     },
     "buildtools" : {
-        "ubuntu1804-arm-*" : "${BUILDTOOLS_ARM_URL}",
         "alma8*"       : "${BUILDTOOLS_URL}",
         "rocky8*"      : "${BUILDTOOLS_URL}",
         "stream8*"     : "${BUILDTOOLS_URL}",

