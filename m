Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD06CCA5FA1
	for <webhook@archiver.kernel.org>; Tue, 29 Sep 2026 08:14:04 +0000 (UTC)
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3090.1790669638292928632
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 29 Sep 2026 01:13:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=eqX23ivN;
 spf=pass (domain: gmail.com, ip: 74.125.225.141, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e721b5503so36727715e9.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 29 Sep 2026 01:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790669636; x=1791274436; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P+JRETw7j7hJ7EgclRXrBPrRtFCceNHU9XMH2RLM65s=;
        b=eqX23ivN75ye+5D8ZJasFsN2YwrjceakJ3Sjsj1zQobOYrXhtjOsu7j/p8bfGvNMI9
         ltrF45HgzANTe2oAyvUon5VIuX9/K7MDbdVF3YykQ/Rtq/sNMYZ6XKmx3BHb0WhtA0eC
         ypIsVksadvF0zGTS8wX9tjVV75LCGzpksX8yho4EKMpRHDxtjywBZhA0v8cn2cCK8cdK
         PS4OGxzsrWfm2au2leQCgx5hh5UilfidCUtd/0uXLVXwhvtJ63O2BsrdaGJloTaCf/sS
         fUDmhty+N9iVUblPuE4q/fIPlS9jiY7L1/YVqn6t+b9r0A5jWE0Cmc8lPb5j3zIicr11
         YK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790669636; x=1791274436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P+JRETw7j7hJ7EgclRXrBPrRtFCceNHU9XMH2RLM65s=;
        b=W0Yk0Ax/l9VY9BxN8DW7E5gkaurD0me0zDVOpamEeoEfYn/OXw9KykMYRm+XugiPyJ
         0LeXIy0Bek9Y+u6YTZU4tgMimKdL2XWKVoLgutxMzT92rMu54k28trBlgC3AbFAKTU/Y
         PEoe2cUXsKzuZKd08qImX0p37eCruTMJCYTHUC9258x+JTDsM/5xbqNU19eDmV8UJh+K
         gOrRY1fYamKDnqyWSBnRj5XQ81LK957tChxDMIyIHDRPFA49x2kI6RZyrNpTfqpVP7/r
         xIyLg36UfRUi1YV5omEg7DEF5UMMBuUN/3BsiDfn5Pld6JwsH+QzzhS6tUFbNXOEZtWO
         fcSA==
X-Gm-Message-State: AFuF++lpp0916AHfjdVr9GGsEmyJyhfJdXeRGA31mf8ZaqrONu7sDxUc
	ZU6oyAipWi+GxZi88aM8WvTHrY5V2ygbWgMf1/xqJZcBSew+DLnY0unBW9R4gw==
X-Gm-Gg: AYBFou003UcAHOB2DJAojWqzsrLZVRo72Ec5bI2RDQ2sGj5oA0AM5VOMH8Aa1zxYpkD
	TEbQC0mRefAxPBXSaCvQYOBsncmLCMYUapUP8S3CQ36ZGHAQ1/waFO8HFPoAwlayBtcRBH3KV5z
	3KSLpC2JGJfTUH8oagjpQ7dutUlB2lIQp2t1u4jtIKII7PmXs5Sdu5IuSTg+wXGr7lM9TCt+v5/
	WedgysGQsfwoKDsUd0RB0Hwmi7QV3yKQhGxBDkGGKFWQBtcJ0YKIgXE7Dr1DWVaVY4KFxylhTKU
	dPjJ7V89RNlWbyttGkGqMBn7Th0cpj04uEmsQO5NfPRnbx45lcxyYdd73nZBxkwLX8zBK7YRumm
	DDaDMXacmgolPQ94kdMEb9vnWJngFot7N5lErGMWFyEujjuzMMkBFLFD+7HVFGl2+yTqhwQxFr5
	entwrwqM11KakUTyTG63zkQ2H+5gvhr9mjCXVcqJO/iD+gdSi6w5oY3KKbkWYp7fSCvycqhINtY
	uSFg3Jf59MtumgPHVZJGZuWrPLOrudQR1JagN+ZRbKPeq+rVbX6ZmC0NMGbYc8+9w==
X-Received: by 2002:a05:600c:c48e:b0:49f:ce72:dfe7 with SMTP id 5b1f17b1804b1-49fe6710a41mr258693615e9.35.1790669636437;
        Tue, 29 Sep 2026 01:13:56 -0700 (PDT)
Received: from localhost ([109.238.212.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cfe16a2sm58659805e9.4.2026.09.29.01.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 01:13:55 -0700 (PDT)
From: martin.jansa@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: hongxu.jia@windriver.com,
	Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-tensorflow][PATCH] layer.conf: Update to blacksail release
Date: Tue, 29 Sep 2026 10:13:49 +0200
Message-ID: <20260929081349.3858049-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 29 Sep 2026 08:14:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4965

From: Martin Jansa <martin.jansa@gmail.com>

Changed in:
https://git.openembedded.org/openembedded-core/commit/?h=blacksail&id=37623ffbdd34a5c6b3e12ee33195f8e82343f198

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index c3bd464..bad8eb1 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -11,7 +11,7 @@ BBFILE_PRIORITY_meta-tensorflow = "10"
 
 LAYERVERSION_meta-tensorflow = "1"
 
-LAYERSERIES_COMPAT_meta-tensorflow = "wrynose"
+LAYERSERIES_COMPAT_meta-tensorflow = "blacksail"
 
 LAYERDEPENDS_meta-tensorflow = " \
     core \

