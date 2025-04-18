Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11394C369AB
	for <webhook@archiver.kernel.org>; Fri, 18 Apr 2025 14:50:50 +0000 (UTC)
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
 by mx.groups.io with SMTP id smtpd.web10.13433.1744987842361462237
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 18 Apr 2025 07:50:43 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 45.157.188.12, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZfHkS2lnvz2tJ;
	Fri, 18 Apr 2025 16:50:40 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZfHkR52kPz1R2;
	Fri, 18 Apr 2025 16:50:39 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Subject: [meta-rockchip PATCH v2 0/9] rkbin: factoring do_deploy, customize
 ddrbin and bump rkbin
Date: Fri, 18 Apr 2025 16:50:12 +0200
Message-Id: <20250418-ddrbin-custom-v2-0-700828527faf@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKRmAmgC/3WNzQ6CMBCEX8Xs2TVtAQOefA/DoW4XuzH8ZItEQ
 nh3G+4eJzPfNxskVuEEt9MGyoskGYcc3PkEFP3wYpSQMzjjKlNYiyHoUwakT5rHHru6aGxdmis
 XHjIzKXfyPXwP6Hn2qCO9KcoEba6jZErX422xx+iPeLFokCtqmtKTq9jeKbLqegkM7b7vPzTmX
 nu5AAAA
X-Change-ID: 20250311-ddrbin-custom-f83918406e3a
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 18 Apr 2025 14:50:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1387

This simplifies rockchip-rkbin-ddr, rockchip-rkbin-tf-a and
rockchip-rkbin-optee-os do_deploy to only have one do_deploy task common
to all supported SoC instead of having to add a new task override for
each new SoC. It does require to set a few more variables though.
Thanks to the variable abstraction, we can now move all of do_deploy
into the rockchip-rkbin.inc file.

The downside is that the version for OPTEE-OS and TF-A are now hardcoded
in recipes, so a bump of rkbin requires to bump those as well.

Additionally, this finally allows to customize the DDR binary blob using
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

Note that I plan on backporting all but the factoring out and rkbin
bump patches to scarthgap (and I assume styhead too). The factoring out
patches would break backward compatibility if someone appends to the
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
Changes in v2:
- factored out rockchip-rkbin-optee-os and rockchip-rkbin-tf-a as well,
- moved do_deploy (and RKBIN_BINDIR) to rockchip-rkbin.inc,
- removed bbfatal for the version variable as it's not used directly,
  only through another variable, which can be overwritten, so it doesn't
  make sense to enforce it if it's not necessarily used,
- renamed variables to be recipe-agnostic (e.g. RKBIN_ instead of
  DDRBIN_ for the prefix) so they can be used from the .inc in the
  do_deploy task,
- renamed ddrbin_params.txt into ddrbin_param.txt to match the original
  filename in rkbin git repo,
- Link to v1: https://lore.kernel.org/r/20250311-ddrbin-custom-v1-0-e5c994ac25e1@cherry.de

---
Quentin Schulz (9):
      bsp: rkbin: ddr: store directory path for the DDR bin blob in a variable
      bsp: rkbin: ddr: make deployed name configurable
      bsp: rkbin: add native recipe for tools (ddrbin_tool.py)
      bsp: rkbin: ddr: allow to customize DDR bin blob
      bsp: rkbin: ddr: factor out do_deploy to be SoC-agnostic
      bsp: rkbin: optee-os: factor out do_deploy to be SoC-agnostic
      bsp: rkbin: tf-a: factor out do_deploy to be SoC-agnostic
      bsp: rkbin: factor out do_deploy and RKBIN_BINDIR variable
      bsp: rkbin: bump to latest commit in master branch

 README                                           | 20 +++++-
 recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb      | 83 ++++++++++++++++--------
 recipes-bsp/rkbin/rockchip-rkbin-native_git.bb   | 21 ++++++
 recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb | 29 ++++-----
 recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb     | 29 ++++-----
 recipes-bsp/rkbin/rockchip-rkbin.inc             | 21 +++++-
 6 files changed, 141 insertions(+), 62 deletions(-)
---
base-commit: 1d920b9c411bc5025a55eccb91cb7ab70faeb0bd
change-id: 20250311-ddrbin-custom-f83918406e3a

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


