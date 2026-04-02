Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79F5CC6B36
	for <webhook@archiver.kernel.org>; Thu,  2 Apr 2026 08:49:07 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11320.1775119736986611168
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Apr 2026 01:48:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=TAWb70YL;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48700b1ba53so5351075e9.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 01:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1775119735; x=1775724535; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=McocNT+NroYo/L5j5V475gYo/ZvHc5fzTin1t4g8K2w=;
        b=TAWb70YLRhoVUehZPQ3GH8ked+5jDFo4CF18xs6zgUCAw/9qKRbQDvAl+jkHdzfF6w
         GA3JAMjFEP1YK+mT6Mbotyhi0jo34jOY4ZAiLRwlArVGXs6any7NsMmC4c0ito1+e98J
         8ZjzWrw0ZTDMAmak8XRYpKemkcZ0d02oorLPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775119735; x=1775724535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=McocNT+NroYo/L5j5V475gYo/ZvHc5fzTin1t4g8K2w=;
        b=KVRC5RMj3zAE1XrMOvHrxw7GhjhaU1wbVcOHZI1xyxC3fR2K0a4jWtCwstr+pUtkzd
         UTvtl+vDgfVK8r2Vh2i4ESHMVHUCADivsDJIwpHwOiPHlalWO4MXxzf6yzjws8vq3vnq
         Cmhl0361ejuOTIJ1TI51XcZAvKaYncMSPxzi6SUJtN4jQqhMpBVadQyFCXUectStG+A3
         WK3JQ++aCiSRqgg/hHKBEZpXYbMWx/LfYMO9yHpAacfLlIhyPinokRJsqmwcUh3Cak+l
         bBa3erkRms6bdjVK93UTXju6RTTBgwpOZam1sA/elJdUHcbCqdAtsT595pozXY21DFwX
         Ppaw==
X-Gm-Message-State: AOJu0Yw+aNbRcGi5T+++ylpkLezdvOub1+k9+bwuTYIM9UKBEA1IajMn
	X7gUq586HFNnhUSRjKh5DJLnM+9UMlH9P5NZBF2YvotJcmYrX7aIDew8gSXBq8HjQFqZVyuOJDx
	J82Fw
X-Gm-Gg: ATEYQzwlDzDlQfgQj4XumCmrGahvfuSREChlhHoczaMKvkMJzTj0im1x6z7lsqr+0u+
	akvvwl0SnbA7oyAUiWp3IZoqm/8HZYNfx97Csh3ZZ0NwcghAVB+4KGoYq4Uerj9t8O1VeNaAmeR
	HOKm3wEehKbxWbO1CeVwjKBxvOM3/q/MPBhWZJzqiwVDKRaUVSibH4n2R6RcaoMKTOYg03meUpg
	dbQoRg/arfp4qAbcPszLbHLpSH5oD61QHMBCc0nAh+WPZVnjlcOKueeKFU/elpwSR1HyXurp/nA
	GHt8d0BMODaspfSshwdpNLCVYxkHELO/jFISC0DBtbN3BA90kTu/rdUf4VkADede3/0tA+FMqbj
	TbdsT6Ll8zB2Q8Uk9KBnMWHQkOPL+gaTpqUXgrArFb90HZqNbC3hI2hvApfx24q4Fcy9iNMy4z1
	bnLpCNVmjDa1cZ629j0fYbrCZq0RLaNs0LWTYp+iunkoo+WCBX/cc6YwVuy3/UGbQ=
X-Received: by 2002:a05:600c:8115:b0:486:f8d6:5dea with SMTP id 5b1f17b1804b1-488835997d6mr110970195e9.19.1775119734924;
        Thu, 02 Apr 2026 01:48:54 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a695:b092:8c54:d70f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a626100sm96407025e9.1.2026.04.02.01.48.54
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 01:48:54 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Unbreak bringup-fast sstate usage
Date: Thu,  2 Apr 2026 09:48:53 +0100
Message-ID: <20260402084853.3346086-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 08:49:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3613

This config line in the template is already also set in the builder itself,
but would break bringup-fast - fix this and remove the duplication.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.json b/config.json
index 51eb546..b45daa8 100644
--- a/config.json
+++ b/config.json
@@ -192,7 +192,6 @@
         },
        "bringup" : {
             "BUILDINFO" : true,
-            "SSTATEDIR" : ["SSTATE_DIR = '${HELPERBUILDDIR}/sstate'"],
             "MACHINE" : "unset",
             "DISTRO" : "unset",
             "step1" : {

