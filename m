Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0614BCA5FBA
	for <webhook@archiver.kernel.org>; Wed, 30 Sep 2026 11:06:28 +0000 (UTC)
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10854.1790766383812770766
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 30 Sep 2026 04:06:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NULLXXdl;
 spf=pass (domain: linuxfoundation.org, ip: 74.125.225.76, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48434392b02so4530209f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 30 Sep 2026 04:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1790766382; x=1791371182; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qr+kW55muFCxJhEAUe8kuW9F0lGt1H+CWHpDCZyIyaQ=;
        b=NULLXXdlN32+bXJP/s2sEm3bPtXtnjrv6HJNiAJPYsBIhEXPtz0gV0TMKAUy01rPD3
         jSaR4OdFR5SYefrpKEI1yMsA8alOtf5qYGhlPw0jZ867WGdRK8Wl5eMVUg/Vk/hYQNHQ
         O4HKxhgjGKTzWM/l3lu6OofHBTQLBres2UO/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790766382; x=1791371182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Qr+kW55muFCxJhEAUe8kuW9F0lGt1H+CWHpDCZyIyaQ=;
        b=BMmod9iHoxxQxLM7PeGQfAFGEwUA8fqsiqckfs05lwtv8fBs1aR9mp4ZAJ+glOMVNE
         ZHNUbbFY+ng4vMJ78TNkh17Bz93dIHPn0Qljz0QgorVQU4GtZrkUF0xf4G0t4SpFllZX
         0XgYfiT5oIU7QmX3n+xQq+jMMlXxGVt2fpCNaHeK1NGJcKqrzK+Vplg3qr4Kjz02Um/4
         PKOLsNRnSXDyA9EOwN7q5ghDzyjsNfnIPo70LeoyQ4YYJvMiGIo39MI43I5IplbQbRlf
         e4Wux3Qd5wpnKEaEJuI42q5vqCZefLWAZrgS93sSx4ttLaSI+tAUlRDhLjNVV5Mxo9Mi
         TqWQ==
X-Gm-Message-State: AFq9FYLHJv0n0OwrRacjIwqNRXL9zFktmXyaQn9J46HSgcGpcv6ff8ab
	5+B+oH36qq4jgdyZgcVNa+VMHNzUCl8Itg42EAg84gReJXV0KjRsYAi6E5jGdLgIbhH6fpuKVlD
	H6RUkmxU=
X-Gm-Gg: AYBFou3lLuYmHrGj0nkGdFT629uvJx4872J/D8aA6932pADaLnQISAusoczE6dEfHJS
	dYIhq6yT3pxUHPcqUhClrgN07kd08yrtHrxnNr2qrAqAsEejad26SOPbK7+hfRviqU0SJuaM7S0
	OwkbwXO64jftdW+dl7V/fdw3wkVZWQOr6k6qpsaVf6ql3JxZL56ndoRR/oW0PoOD9pz8snjm2sD
	c2xxnLDAdYLNZbcD7JRwmTxU7eRk7ipH92+eYb+39rXHOHKMtUpCmVhUrRBOFzLWyB9JM2+uTTp
	I0ziDTbZ5JF0QuvXCNUEH/32ZqtV2udSZ9kGVK4xTT4hVVD0aw/pnv1WzR+XMppFCssRFI2H3gp
	z/9KkTqPBXAWyFr6T1xstPZHgHFHOLmnNBv7SSLb2m+4wywTFNcBl6mr4Uo3LFWqmqxrtO0FDkT
	a9x4ul8K7jo9xmpw1GxYiWoD1zoTvn9vEnlnxYQCBDKF7VsctQoC0YBE9iTVbsxEu8xtJhaYol1
	DxDH5326EWGt5+/Dz6ie+g0CA==
X-Received: by 2002:a5d:5889:0:b0:488:8568:bb02 with SMTP id ffacd0b85a97d-48b0250efc8mr2247672f8f.23.1790766381551;
        Wed, 30 Sep 2026 04:06:21 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:349:f135:e106:4c82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b029ff46bsm2769612f8f.29.2026.09.30.04.06.20
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 04:06:21 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Renable meta-aws as it works again
Date: Wed, 30 Sep 2026 12:06:20 +0100
Message-ID: <20260930110620.571680-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 30 Sep 2026 11:06:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4971

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.json b/config.json
index b96a4bd..370ffde 100644
--- a/config.json
+++ b/config.json
@@ -689,7 +689,7 @@
                 "BBTARGETS": "agl-image-core-autobuilder"
             }
         },
-        "_meta-aws" : {
+        "meta-aws" : {
             "NEEDREPOS" : ["bitbake", "meta-openembedded", "meta-aws"],
             "ADDLAYER" : [
                 "${BUILDDIR}/../meta-openembedded/meta-oe",

