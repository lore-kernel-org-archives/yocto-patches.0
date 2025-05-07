Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC28AC3ABC5
	for <webhook@archiver.kernel.org>; Wed,  7 May 2025 08:27:41 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.web11.3808.1746606455132758169
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 07 May 2025 01:27:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=VVotX5P6;
 spf=pass (domain: linaro.org, ip: 209.85.167.53, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54d6f933152so9024069e87.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 07 May 2025 01:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746606453; x=1747211253; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AON9W7B2B9IdsWYTsVLe/gbcHHrXk1kbUEo+qu1I1Z4=;
        b=VVotX5P6zUjSaPf30vEQ3f+SplGVIphHgJZTE05tLuHLA7/msyl5DeyHI65CFGSUiw
         p7Y7xbYg2/PvzLUSWHi6D8Jxbeec3PfRPTDoCYbILljveUzIwgtmhVdHB9xYheLZJGSv
         K1K++HjCN8FrK+29ynhZyPEvsw5sBNPgkJbGty4HknplVLuLJVqpJd0O4d9aErl76WCV
         Vr3CpymEWayN5ezAWM8lb+Or+NcsNBCB5J3Tqip10m7RRvopCuh5VS89//3xIvXuNEFu
         PlqsM5XOO+6WdXjwcH2q/aaZfCgGX6XKDOH8Oqriymc7kGo4S6IqC4W7ooDg0UUg8IWT
         FB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746606453; x=1747211253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AON9W7B2B9IdsWYTsVLe/gbcHHrXk1kbUEo+qu1I1Z4=;
        b=pNiMDTaPWOL1N2DOo2FVEriWUeiWarCIzca0ae7Xo5Wa4rQl3R5H+sOBV6CaWmHJOC
         SRM9CnTxVvZ8jjsFUnqksx49t4gXNhdtJgDhD/ev6tgYi1krwFKupMymqsdDfDngorGL
         01/02OM052MQ/g6sFiD5DQb+9+w53y9nmW0ZgZvYOAdBHy37/4nyVErmRk2lXeJ2K+gs
         jwUSlog883kgKBwKEKo6B07AOqt3VzOy2omPHTjrMDFujDDCAvOhdWkgLxlITxC0GkIx
         18QjJMTCTKqUnxmxuchPfntyEk5UMt4yuCaYyyEd3ybDrT6anYKDlulhMNLuutnF2XBS
         Wljw==
X-Gm-Message-State: AOJu0Yw4x1vxgemlcRKH38JdJv6vj0Ho0H5HJVZSBm7o0xTbvAl+sUBY
	YV2aSmJK5duD3/uXB9bHKbqvPMBwX+5X1PLYDvfEZ4leJwLZGPxs6FZoIOpSRFMgWlMztNkFjyE
	ZIGw=
X-Gm-Gg: ASbGncuJGYYfeQUylVn2uLO4FlLn4ZaQpFAbxjJG0U1KEZLZ/+W0WJDx1GIWeGMrvPb
	QkeAja7JV5hpDxhg1eNYloytuq650qTCK3POVCoOEChNAYLTCkQH60v9qLSC/NTwIV1su3rqMvZ
	pwFVNnSppi7p6GqYZhVN6cZoAH/Vda6gMfy2DrGvtgDXf3FvTIDyt+GZRpAyggwWCDmIF4kgiTR
	J3Tdkwf7xpmFsGKjUSqJvARcnYhBgr/5kveYw/W+kG6rhOecTnLwTqMEuN0tewb9yyZlLnu7+iK
	PCOzWmUabFKG4SvgGYHQSQedqNgw+mcu7LSSdeVVTCfA6wGdq2A7N5/NiwUYtrbcYsXcxIDey4p
	oZ3sMt+1sAUeOc/NE4w==
X-Google-Smtp-Source: AGHT+IEUnDB/zN2Tb6xdH7CrkGzGTs97cx6RNkg7GB3I6s+KxoPzoRtZQ9z+k3kZxtmcyNS8zzhHyw==
X-Received: by 2002:a05:6512:220c:b0:549:8d67:c48e with SMTP id 2adb3069b0e04-54fb96035b2mr752125e87.29.1746606453255;
        Wed, 07 May 2025 01:27:33 -0700 (PDT)
Received: from localhost.localdomain (87-100-218-141.bb.dnainternet.fi. [87.100.218.141])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ea94c8e7bsm2266719e87.101.2025.05.07.01.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 01:27:33 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 1/3] systemd-boot: whitespace fix
Date: Wed,  7 May 2025 11:27:17 +0300
Message-ID: <20250507082719.1220303-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 07 May 2025 08:27:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1522

To fix warnings from new bitbake.

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 meta-tpm/recipes-core/systemd/systemd-boot_%.bbappend | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-tpm/recipes-core/systemd/systemd-boot_%.bbappend b/meta-tpm/recipes-core/systemd/systemd-boot_%.bbappend
index 712a764..55323aa 100644
--- a/meta-tpm/recipes-core/systemd/systemd-boot_%.bbappend
+++ b/meta-tpm/recipes-core/systemd/systemd-boot_%.bbappend
@@ -2,6 +2,6 @@ DEPENDS += "\
     ${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', 'tpm2-tss libtss2 libtss2-tcti-device', '', d)} \
 "
 
-EXTRA_OEMESON:append= "\
+EXTRA_OEMESON:append = "\
     ${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', '-Dtpm2=true', '', d)} \
 "
-- 
2.43.0


