Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D78D2ED0F
	for <webhook@archiver.kernel.org>; Tue, 20 Jan 2026 15:14:57 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8622.1768922095769907799
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 Jan 2026 07:14:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=EMhT53QV;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47ee807a4c5so41155225e9.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 20 Jan 2026 07:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1768922094; x=1769526894; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GXSy9bWpHIx2Lcs/s/PuVimmmcadyZTUl4szHr2FT3s=;
        b=EMhT53QVP9oYsx9cWK0/1mDpxaJi1wUrBSUVfzuVTbNMtwC5/OSIvst5y5GGJppZVf
         gpUxEHrchIRUyr3VcPPAoh4fmMHrUjelm1KV+sOtNZFPwXdok9PZmss5dW84JL3YzbDQ
         JBXmbLj755KtmibLIDTvIWuGyZBLR4FsFisVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768922094; x=1769526894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GXSy9bWpHIx2Lcs/s/PuVimmmcadyZTUl4szHr2FT3s=;
        b=AuXreJpldeTh0XIEyq9T/qTPvHZvsgaT7bhyS6KNSNdPxBSMzCc3YQf6rq6uhP9tnD
         j3UCgM+BmIMgpwC30fPiIi55/SUZgKXqB6afC6w2gCaWCAoPTMkul5gLqypQuc+Sw+n/
         WbYUV92gKPyHrlj5iBFVlfP4CeBGELissHt1mEfClqGUoHhiwwAW00YxiRardVEsGn8n
         JR3GT1flMCEP6CwfGYCXJdc2cocDImCPvhIoqLcTclr46yj38v1YJXM0eAI0u+uKRp0Z
         k3Zb8WaCvIttPe8Tao4PwGbXjD+cjUUto8s5KPb9uBAMkT6Leu6oWdFB5xbD8tE/eIar
         GufA==
X-Gm-Message-State: AOJu0YwX85neMsAX8Q3AC8K5A857H+75kNw3YDtMqFaxLDX45k9uInHg
	WrmgacfQy+dTAYHjHq95YNRoB6vW3yISBhN/6dgjJ3bZZCM/HUMspP3D21VgQTgav48d9Bs1KhQ
	v0PdRSOo=
X-Gm-Gg: AY/fxX7qDPZqe5aNj63OdnrpgpDLURMhNU0HFRJEgOOugldZRFmxAlJ+yaLEAQ6JGC8
	QdiZP5LDUSHvQ01ycqNjTswBYQ6Cyh1dki0c1lYYI1QmBEn9OsnbsWLVaBIgcv8DHyAlpbffR1l
	fALSy9uAVf6ogYMqQLYUPPYmT+pbhxY/285ViOE+oKQrWeYuiClzwIK4cSizxQ1ThKrOXv+a3Fr
	1M/N9vLAR1fSTOUOxwwmN4TPY8DDk0hp1qPb3/ax2A2mV4bztoeQoT+ckr9QFTIgR7EQCBHRBc1
	2lt7135ptLknRHzXI4bAkT8vX6Akjk+9+0stW4a6/3H9Uh1MHCUlPCDTLp2Xabw3Js5HFT0GaS7
	vzEf5QgQP7mE9WE3WLL8JhNPOUDcBW4MXY3s0frUk8oYqwix2fxrA55EdennEnqIC+7+laHj8aA
	N1R4Z49rTA0DNBxznCIesNRDTIpUFwwop2MpZ6EA==
X-Received: by 2002:a05:600c:37c8:b0:477:af07:dd21 with SMTP id 5b1f17b1804b1-4801eb0d71cmr172010895e9.25.1768922093575;
        Tue, 20 Jan 2026 07:14:53 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:62c:c694:1cc8:4ee1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997eb1fsm29966452f8f.35.2026.01.20.07.14.52
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 07:14:53 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH 2/2] scripts/send_qa_email.py: Fix master branch comparision for regression report
Date: Tue, 20 Jan 2026 15:14:51 +0000
Message-ID: <20260120151451.3809578-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260120151451.3809578-1-richard.purdie@linuxfoundation.org>
References: <20260120151451.3809578-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 20 Jan 2026 15:14:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3033

This change only affects master builds. These were being compared with the last tag on
the master branch which is currently "uninative-5.0" and clearly not what we want to
compare to. The next tag back from that is "yocto-5.1" since the 5.2 and 5.3 releases
branched before release/tagging and also isn't correct.

Instead, list all the yocoto* tags and pick the last one which should be the most
recent numerically. That is currently "yocto-5.3". There should be test results
available for these and they don't need to be on the master branch history for the
regression report to work correctly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/send_qa_email.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/send_qa_email.py b/scripts/send_qa_email.py
index 6fb121b..e3de4b5 100755
--- a/scripts/send_qa_email.py
+++ b/scripts/send_qa_email.py
@@ -28,7 +28,7 @@ def get_previous_tag(targetrepodir, version, log):
     previousmilestone = None
     if version:
         if not is_release_version(version):
-            return subprocess.check_output(["git", "describe", "--abbrev=0"], cwd=targetrepodir).decode('utf-8').strip()
+            return subprocess.check_output(["git", "tag", "-l", "yocto-*"], cwd=targetrepodir).decode('utf-8').split()[-1]
         compareversion, comparemilestone, _ = utils.get_version_from_string(version)
         compareversionminor = compareversion[-1]
         # After ignoring rc part, if we get a minor to 0 on point release (e.g 4.0.0),

