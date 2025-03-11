Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45274C282EC
	for <webhook@archiver.kernel.org>; Tue, 11 Mar 2025 11:26:50 +0000 (UTC)
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
 by mx.groups.io with SMTP id smtpd.web11.6693.1741692403645270740
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Mar 2025 04:26:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 185.125.25.8, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZBs0d69Xwz3mF;
	Tue, 11 Mar 2025 12:26:41 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZBs0d2fNwz63W;
	Tue, 11 Mar 2025 12:26:41 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Subject: [meta-rockchip PATCH 0/6] rkbin: factoring ddrbin do_deploy,
 customize ddrbin and bump rkbin
Date: Tue, 11 Mar 2025 12:26:29 +0100
Message-Id: <20250311-ddrbin-custom-v1-0-e5c994ac25e1@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOUd0GcC/x3MQQqDMBBA0avIrB1ITBXbq0gXMZnoICYysaUgu
 buhy7f4/4JMwpTh1Vwg9OXMKVbotgG32rgQsq+GTnW9Mlqj9zJzRPfJZ9oxjOapx4cayFiozSE
 U+Pf/TbDTaVGS29zKB7xLuQF/0avMbgAAAA==
X-Change-ID: 20250311-ddrbin-custom-f83918406e3a
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Mar 2025 11:26:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1182

This simplifies rockchip-rkbin-ddr do_deploy to only have one do_deploy
task common to all supported SoC instead of having to add a new task
override for each new SoC. It does require to set a few more variables
though.

Additionally, this allows to finally customize the DDR binary blob using
Rockchip's ddrbin_tool.py tool. This is typically useful if your board
isn't following Rockchip's HW reference design, e.g. using a different
UART controller or pins for serial output, or using a baudrate different
from the default of 1500000.

Finally it bumps OP-TEE OS, TF-A and DDR bin recipes to use the latest
commit in rkbin git repo.

I am not too fond of using a file as input for the customization, but
this is what ddrbin_tool.py uses and there are possibly too many
corner-cases to handle by using fine-grained variables. So for now, I
decided to go with that but that is for sure not the only possible
implementation!

Note that the bump commit wasn't tested.

Note that I plan on backporting all but the last two patches to
scarthgap (and I assume styhead too). The patch before the last would
break backward compatibility if someone appends to the
do_deploy:<override> task. The last patch could be merged but there's no
absolute need for it?

Lastly, the patch about customizing DDR bin needs to be modified before
being backported as it uses UNPACKDIR which doesn't exist in scarthgap.
The logic should be safe to use with ${S} (for scarthgap) though!

@Trevor, maybe you can check if that would fix your issue with the
RK3308 DDR blob you wanted to keep on that outdated version which is one
of the last versions where the UART you want to use exists? It'd be nice
to get rid of the rk3308-specific recipes I believe :)

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (6):
      bsp: rkbin: ddr: store directory path for the DDR bin blob in a variable
      bsp: rkbin: ddr: make deployed name configurable
      bsp: rkbin: add native recipe for tools (ddrbin_tool.py)
      bsp: rkbin: ddr: allow to customize DDR bin blob
      bsp: rkbin: ddr: factor out do_deploy to be SoC-agnostic
      bsp: rkbin: bump to latest commit in master branch

 README                                         | 20 +++++-
 recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb    | 87 +++++++++++++++++++++-----
 recipes-bsp/rkbin/rockchip-rkbin-native_git.bb | 21 +++++++
 recipes-bsp/rkbin/rockchip-rkbin.inc           |  2 +-
 4 files changed, 111 insertions(+), 19 deletions(-)
---
base-commit: 0aba79e47951b049bcdd39e07f660c665e257393
change-id: 20250311-ddrbin-custom-f83918406e3a

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


