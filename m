Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA3AFC9EE5
	for <webhook@archiver.kernel.org>; Sat,  7 Mar 2026 10:30:15 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6727.1772879414466595898
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 07 Mar 2026 02:30:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=mTDiqDRX;
 spf=pass (domain: konsulko.com, ip: 209.85.219.46, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89a000f5adeso115613896d6.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 02:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1772879413; x=1773484213; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GAMS4yzRMGH+2fXLA3Sj/A7gS/SBJwIyDxX3Fz3PWzU=;
        b=mTDiqDRXiZ8d16WrersiXIy9oDJQCc8hWhBS4JWgWiSX1mWJ4H8BDZ0VEEohp+AkeL
         SUwuVmoJM77OeOaOoTVWbbPUF+hW7TTBhVBrM8AoHJR29WFf5g1n0TtPJ8TCELUdNI8Q
         XIVrxjIwCZrnZF1BW11XEjSGR+EttlNGvQ/04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772879413; x=1773484213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GAMS4yzRMGH+2fXLA3Sj/A7gS/SBJwIyDxX3Fz3PWzU=;
        b=pO7SU9iWsWxBc/Q5Di4kF+SEuk/8p5LFZkYo3Dh+wyZFN6gBet0O0qx1GtioCQlDaO
         naSBbQ9JW3GTZI5k4vGIrMUhSyoxMUhzRVuPwRPh29Yy2HlRxrWaUHjzoCd/5fFOZ4N9
         OHnp2dueszVMM4wMXpb0/XeY+SN6ZJU2JXUysewVbA3uscp2d70qNqGdVyFeQCvRF44p
         NCu9oypY0A0Z1/khOha6vpImpao1TxAz32Uq9zpYo4IwWdQbfFTcZf05m512LAX+qorm
         Rw4AHRk9PITZw56BrTiX6yzdkKkbBe5GTzx6d4qg6DqCyn7/+FRTXNGZS5XCui5Zkccc
         PyYw==
X-Gm-Message-State: AOJu0Ywfcuyp5Lo7Z49eklDIOfNXTLQaYhq20pV7P5xxlU/vExDVegYT
	PdZnoR5dL+QQNDNimMTW/6kIejlj0NOg+OABR839omKPPue6nZpKh0WlrQGjw0iSpYItfNVyzPI
	B/9Latas=
X-Gm-Gg: ATEYQzz4Ppd35UX+2iH1XjP9DHNMcOnX0psBa7e9/CIZdXixyyCknB/vEg6BWRfl8aq
	ByWgHxVkf1cDub/V7KZ4rdJPbsQnJgC37TH0U19jG0QFCFicd+DhIY5A1KHK2l4DCegjMivdcrt
	/WuXUjTC7Ku2pUHgcCvQTekKPPD2Flbp+X8ejbskZzGEU/VWBkMcV7PTKP9DV7yif5/uVyDg5y9
	wUP1ddE3n4jSyNDmIGlJrtkHTQ89JZMfq9cFBMB4VD4mU5NRtGlH2mnjaKY3UY/bgtzfMxBEtC1
	ysgUr2LrmF0R1wtjsCHniX9L4clOpQp2hYlwTeaajI9Z2CUATZMPVAjnJz09iXdYmCepgtAsfNI
	Y207A+Vr9kdMhq0G5a4H1x/iq9GWXCNBPzZVNWaV4eUJiNprLWROAUJ/g4SWlS6ROuaPCKYNo5v
	Rd5N1B5kWyDOXCw/+Fs96WmjmZuhPvGv/m4xlUGLFfn9ccVwTE+dSZb8EIVfvKr1kf8hputZQu1
	H/GYmdZxbjxK4FP9vbsWxcloVBLgWx2Smz1AViD0x+Cq977dmnbIfw3SBQXqaeaLKz079blFDM=
X-Received: by 2002:a05:6214:da5:b0:895:7864:f69d with SMTP id 6a1803df08f44-89a30aa0ce4mr77172166d6.40.1772879412899;
        Sat, 07 Mar 2026 02:30:12 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a316ea1b1sm31472556d6.36.2026.03.07.02.30.12
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 02:30:12 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 0/7] Assorted updates 03/07
Date: Sat,  7 Mar 2026 05:29:54 -0500
Message-ID: <cover.1772879169.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 10:30:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3365

This patch series rolls up the contributed patches from the past few
weeks, plus a nikto fix from myself.  These changes are queued on the
master-next branch if you would like to check them out to test yourself.
I intend to merge these to master branch at end of day Monday (Eastern
Time, March 9) unless there are objections.

Scott


Changes:

Clayton Casciato (1):
  suricata: improve PACKAGECONFIG[unittests] control

Peter Kjellerstedt (3):
  fscrypt: Correct the spelling of DESCRIPTION
  fscryptctl: Use ${prefix} rather than /usr
  fscryptctl: Correct the spelling of DESCRIPTION

Peter Marko (1):
  python3-tpm2-pytss: BBCLASSEXTEND native and nativesdk

Scott Murray (2):
  nikto: fix branch
  A couple of small CI fixes

 .gitlab-ci.yml                                                | 2 +-
 .../meta-perl/recipes-security/nikto/nikto_2.1.6.bb           | 2 +-
 kas/kas-security-base.yml                                     | 2 +-
 meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb  | 2 ++
 recipes-ids/suricata/suricata_7.0.13.bb                       | 2 +-
 recipes-security/fscrypt/fscrypt_1.1.0.bb                     | 2 +-
 recipes-security/fscryptctl/fscryptctl_1.1.0.bb               | 4 ++--
 7 files changed, 9 insertions(+), 7 deletions(-)

-- 
2.51.0


