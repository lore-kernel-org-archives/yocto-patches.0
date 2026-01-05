Return-Path: <t.f.g.geelen@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6DFCD0420
	for <webhook@archiver.kernel.org>; Mon,  5 Jan 2026 22:50:34 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.77818.1767653424631721814
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 Jan 2026 14:50:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dQpImsbc;
 spf=pass (domain: gmail.com, ip: 209.85.218.52, mailfrom: t.f.g.geelen@gmail.com)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b73a9592fb8so87999966b.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 05 Jan 2026 14:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767653422; x=1768258222; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S7fzq0J1rX80QMzttCkEjLbQjLND+Yb12wlVMvD8cr8=;
        b=dQpImsbcbwSIzDxeHNIvqFEe9/wxEicglfPus2SVGl+42H9C2qoh0UquI/xMwqqerd
         QpBXMrI6mymJy15oJEtMGqCBKZS0nFZC9+bpsMCkG0XF4FP5NthnwXxjVYraPFoLPnkV
         n/ZqO3zgIlYDHz+KHaTpBnOrLCfykPb99WYj9tYqYPWFDNnPyglxNX4+/YSJ1xwW+IHi
         0vZ7UADSjp987efbjILFJxCbRM/7JiZ2OJ4InLeCKj1BIvEsPvRqukiwTI0SB4+7KLVA
         +i4F4IlQD/9/hlYUSANCJTVtndMTDP+Q8CA/30oj4R+K6poZPi+BQR589y5Dkvbq2vmO
         ITPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767653422; x=1768258222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7fzq0J1rX80QMzttCkEjLbQjLND+Yb12wlVMvD8cr8=;
        b=BSZHdRv23aXwkYKCxrn+F+rbY8aNd2dCDSRROo+Ax0FuY50Dlgr10O3pYB5r78xc7s
         MyOuXG43TI9CNor7A/vxon1S62ni0xqp1zO3kXj0P1WNgAfv/SUBEi8zyHULoX7Mea76
         1SUTxUTDOkrvZFlJrMoYzEyjcN/JIa3DjOHCPudcFxHDRozFrF/9WwATMtj4nmy7jzJ7
         /+Qe/a79Na75r/sdYfFecOirYdLoCvbz2x/VcDruFIP/039xhI1KFdAohc+/tG46Yjj2
         wgewf4GSxTH5IziM52uwSPuWX/BL9/w6dQxTrnF7xlMFowAh1c2z9c1ZSE9w6C5HhEhv
         3/gQ==
X-Gm-Message-State: AOJu0YxoaE7/5S6ematZmDZzK3WpA0G5hWf5HY+MdEyx+iIfenmvqiUR
	P0IYKynHBSGNau8u19WJtIeZJyLyo4vVt3txUqNC30TjdwHwhL48X5RjRYolFMDP
X-Gm-Gg: AY/fxX4IpHxofOmvWOw9I01TeOaYBjZCXe4G7o9s/KROI3GJbuTVElXg28CDSMO0RgP
	YZ3xUWzC7grcAnZMaotXLdlXi2IKDEbHPGD0gS0E+3eYqApXQQTuCFYrIjEUS5dF2JD+81YWE+8
	tdqpfPwEYcgvc9KlyilYkcgJONtRzzlquq36+YlW10WUbHmmzbKsVXXaxjI9R2yZe6AyvwmtTPX
	xKSCpDkQfl/WPIpwtCE1ImVFySjqWBF+w515TfEGAeBJQDhWy3fwtpdzL4+9hOJ6ZZbu7Lk6wG3
	Bcthno1tTd/mOlW+xfp5a6R1IH+LcPavOlSkeJA6H0nOQbejO16tgcYlUCHM0ZNfpwyingRzOVZ
	xxZ9CA1/+oWRWe07NLfKC+2kH+oGBbCDJeP1yxDR3ToR0hPhsjB67MLyu8bwsXQMghn5ZV0fM4m
	pr/Jq2Jx+gqjEATNbUiYtTHxvocCkrcFwAYksbOHMSk42NNN+P9WxoZUBsxp5L1U4/5Hta55fLU
	dc=
X-Google-Smtp-Source: AGHT+IHOvKRNDqh1V8/CTbg0xdwWSvnS2ia7higPpdb2n/Iq4Ptk55NGxtAvv4+SBELMyeYGVWTR8g==
X-Received: by 2002:a17:907:2da8:b0:b71:60a3:a8b9 with SMTP id a640c23a62f3a-b84299bd250mr75249966b.29.1767653422303;
        Mon, 05 Jan 2026 14:50:22 -0800 (PST)
Received: from control-center.fritz.box (150-12-20-31.ftth.glasoperator.nl. [31.20.12.150])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a233806sm48908866b.10.2026.01.05.14.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 14:50:21 -0800 (PST)
From: Tom Geelen <t.f.g.geelen@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Alex Kanavin <alex.kanavin@gmail.com>,
	Tom Geelen <t.f.g.geelen@gmail.com>
Subject: [auh][PATCH 1/2] Handle 'nothing to commit' gracefully
Date: Mon,  5 Jan 2026 23:47:45 +0100
Message-ID: <20260105224745.581549-2-t.f.g.geelen@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 05 Jan 2026 22:50:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2897

In case devtool hits a problem where there is no file to commit it would normally reports the full git error. This is an
 unintentional side effect as something else went wrong (devtool upgrade most likely).

Catch the particular 'nothing to commit' message and ensure an early return without raising a cascade of secondary problems.

Tested with perlcross compile failure where no file changes were made. Now the error is handled gracefully.
Other errors like 'merge conflict' are still raised as before.

diff --git a/upgrade-helper.py b/upgrade-helper.py
index 165fd42..002c3dc 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -414,14 +414,12 @@ class Updater(object):
                 I("The commit will be reverted to follow the policy set in the configuration file.")
                 self.git.revert("HEAD")
         except Error as e:
-            msg = ''
-
-            for line in e.stdout.split("\n"):
-                if line.find("nothing to commit") == 0:
-                    msg = "Nothing to commit!"
-                    I(" %s: %s" % (pns, msg))
-
-            I(" %s: %s" % (pns, e.stdout))
+            out = (e.stdout or "")
+            err = (e.stderr or "")
+            combined = out + ("\n" if out and err else "") + err
+            if "nothing to commit" in combined:
+                I(" %s: nothing to commit" % pns)
+                return
             raise e
 
     def send_status_mail(self, statistics_summary, attachments):
-- 
2.43.0


