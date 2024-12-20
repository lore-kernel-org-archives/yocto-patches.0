Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E71E7718B
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 14:05:22 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
 by mx.groups.io with SMTP id smtpd.web10.152492.1734703512997113812
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Dec 2024 06:05:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=LxX6MJ6b;
 spf=pass (domain: linaro.org, ip: 209.85.208.170, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30034ad2ca3so17278331fa.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 06:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734703511; x=1735308311; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAn09M45qPTijb7DmjhZLK8cQN8E78bzRqk6zff92S4=;
        b=LxX6MJ6bOs3fr6u0hNRPsJN0WThfNhsz3ss2Qovnlg5NmpiBEP8mxjljr0SeFcdeOq
         EKZ4yrlyDrd3rnZIJkk02wsZSwYrObcCei0bVwbLrcIqvdAcQ9C7oyzJAtWGAdXHYOKT
         1NLqrX6fbt+SIm4KegYR4T0vtqFAVDQ0C0cmTV8RcJg9oBeW/TBaomgwB0HBAe2A/lyz
         CS3v/5uekPIhcVOZhHWr7ECW/INEi9nIgRgZUy+B3Azujj5brIH5NDoR31GGcR8ZpVEq
         rWG6Aj1/rU37b7pCbELO2UgV23JCi4NH9Cz8oNKSq5j1l+E1yeKoC8bYA+TfxQXBlNQV
         W2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734703511; x=1735308311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAn09M45qPTijb7DmjhZLK8cQN8E78bzRqk6zff92S4=;
        b=SypugM4m2N2CNDmFflFnz0CyoPl2106wfJorapW7Nqn9ZLFU+/ocPb5OMWCJQ1SwEt
         4G6VXpaOz4CddvN0taSUiTNZQiFfoKMOqAbBMIVoOc5DpZ+i+M2w/ziGXGUNwOezNNBH
         ZVlvVojvoKYBbfR0VHUxyVbJEn7RGA4wHo+TG8xkHdmhZWLk7wx9jp5OBamviz7ckQO/
         JpJNjCh3sGF4z7IOnOHLmOQkXEXBuQOga5Th+FyyfifdDZg9mLCrNevbdsWTOe63jKAG
         IPTksIBZT1IDrhfJEfShqef0t0ifKnFIRA+uUL/MCcxqI5O5RqmL9w4WiognHythV3i7
         Kb+A==
X-Gm-Message-State: AOJu0YybwlmGl5ZmGm26+tCBeUH7aCRKIC09oVWAPMpbQqgglGsif0PK
	ZOarLf9laRttjlgJb5PYjb9hvBgnQ0fY9OihWaPp2WQvN0yh8psbJKFa75b5aUTTl/PFY1BzdeY
	ZZeQ=
X-Gm-Gg: ASbGnctXKWx77siBKqwCsfjh5Q6ZOyJXDt6DpPhEAC5Y3sTm4Jf/93QU76mqXgThUs5
	Ji5ILbjKBLjKNOdO+b/mRbCvFj6qgppGA5p2mbGunWsKqzs3oq5/kjR6IXfP13MPEnkLNULga5N
	GKj1E0sthikpCgFCAr+Ku9TLGwo9A+nlHHHEZrszAC/8DHhUHh3yQc2p/2vJd2/evl5wXoDcKgZ
	LnU4q1HRxLiH7I4CMC0Awh1AIcNjjwLFbsvP13CZspvfP/vyRRLzij4zsqM75J0KUtX++dPP/iP
	Yvkn8RT2LpgUQ0ht0+jqckuFRA==
X-Google-Smtp-Source: AGHT+IEcrev+qhFaq+LP8oogEQLsqUMHSUslz16yq6o9qN6ZssmV79u+nwL9Ld4QlzMZfNqY72v+fw==
X-Received: by 2002:a2e:bc0c:0:b0:304:57dd:2641 with SMTP id 38308e7fff4ca-304685c27cdmr11476341fa.31.1734703510947;
        Fri, 20 Dec 2024 06:05:10 -0800 (PST)
Received: from localhost.localdomain (78-27-76-97.bb.dnainternet.fi. [78.27.76.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad6ca8fsm5227191fa.14.2024.12.20.06.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 06:05:09 -0800 (PST)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 03/18] chkrootkit: change download from Ubuntu to Debian
Date: Fri, 20 Dec 2024 16:04:26 +0200
Message-ID: <20241220140441.271395-4-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220140441.271395-1-mikko.rapeli@linaro.org>
References: <20241220140441.271395-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 14:05:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/942

Ubuntu server doesn't have the file anymore but Debian has.

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 recipes-scanners/rootkits/chkrootkit_0.57.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-scanners/rootkits/chkrootkit_0.57.bb b/recipes-scanners/rootkits/chkrootkit_0.57.bb
index d35f5f6..c71b45c 100644
--- a/recipes-scanners/rootkits/chkrootkit_0.57.bb
+++ b/recipes-scanners/rootkits/chkrootkit_0.57.bb
@@ -5,7 +5,7 @@ SECTION = "security"
 LICENSE = "BSD-2-Clause"
 LIC_FILES_CHKSUM = "file://COPYRIGHT;md5=fdbe53788f7081c63387d8087273f5ff"
 
-SRC_URI = "http://archive.ubuntu.com/ubuntu/pool/universe/c/${BPN}/${BPN}_${PV}.orig.tar.gz \
+SRC_URI = "https://ftp.debian.org/debian/pool/main/c/${BPN}/${BPN}_${PV}.orig.tar.gz \
            file://musl_fix.patch"
 SRC_URI[sha256sum] = "06d1faee151aa3e3c0f91ac807ca92e60b75ed1c18268ccef2c45117156d253c"
 
-- 
2.43.0


