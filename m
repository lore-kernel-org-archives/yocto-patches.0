Return-Path: <yannik.tannhaeuser@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A9DCCF2D6
	for <webhook@archiver.kernel.org>; Mon, 19 Oct 2026 11:31:12 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32297.1792409466044914349
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Oct 2026 04:31:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=D2qbag4S;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: yannik.tannhaeuser@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso22000045e9.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Oct 2026 04:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792409464; x=1793014264; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GfUh64d7pVC0NXmE5xUp4fS8BjbWFZ4ADTgJ9wxCl8Q=;
        b=D2qbag4Sf7PG4VviIF5FE+plP6GdHwtDGEsC45EsKl2Q9+94AgcXf9DZrHsllcXK9b
         K1mw7iZWGFyuCacYpEBw58c1VDLtVSVo3CCsZW0GdC6J05JL+71V9bHfmZWP8De1CxyQ
         I2KmsfVNgYbgwo3C5JCHH0TwbZpB5ZvE+sLom1fxPfx9EVq2GnMJkuLjcCMWfgLsaLas
         sl7VBlMGcnxILBH6L81l3Y4VbzHB7rgc0jHVTmi7rCu4+BEeaTY7QOz/P2h2dW6G0bDh
         7vQ2+b0Qfwqi2KO2HtVrfUHQzf1bSNG98kSoWBbSCyLccNk5IuX1FnLmy326FbGV+wax
         TO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792409464; x=1793014264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GfUh64d7pVC0NXmE5xUp4fS8BjbWFZ4ADTgJ9wxCl8Q=;
        b=lcdZ3DTj0om/GuWE1rQPBVidDhP8qXzc9HmcE59Q5DMgBDJwXGdFBlOrFINnB0+5eD
         u3YP6mSei4az0Q1roMrHCddpF+LaZ9K5fbKtA4BTqDQN4zyDCfFCNGLZCiR2fqDFtcnn
         m08Xjdx6hh+GxW7Z+LdqlIh3cYzzKuLvlBTZd2S/5usI/9dcglYY9PN1/RdL+i+2g5ZH
         tgKvjFX0qrZZKpYSX+M+ESlLIdr9a453IGRhzJev6s+JiZSOSN7zMhAP9FQvewJPTfTx
         CzEafjJr2b/Cx0QI0t7CuFTWUsPKeD5xWazWOOf1erhCZ6QdjcKPaGG/4u5gP4lFUeHh
         rZ6A==
X-Gm-Message-State: AFq9FYKPl+XTgV1gP8TdpXO1owT3w+Z7pvuqwk8Inwrx4jns7wIqpPZu
	YY96uNPtU1p3XNBv4SctM8vHVzNLhqiIHM++rFavFRlouCnrFJQRRoFu
X-Gm-Gg: AYBFou0NMXssGBu3E7ys2VNsz0+83rbAzfPrXIGuYvyko/IB7h8SB2jzaF/maT/8hQ4
	LglmqKBW8kLTWN3VksDfCYpdpVeYJ3I0AAuqAUELfUPXQNRpQabHt/5bcTkVzI202cPajpPqdg8
	NKDzFPa4V57ZfAHccrKGsPpeT3hkolKf6so8icNTCIMryuiYYAKIO3EE5HxS/dKX1PhTd1BTCyy
	CoNSCSRm3TtqyYPwvjQWKmyaxe8rD2TY6mN0j4YE5jIGFGkr+eeeRMP/0Vk41phthLJD0AKgt6H
	m3v5nFdUfXXpDr1wuKrKCXYyP6LueQlQ2CJ1gZBs2av/EbjKLhI3I283ymGX861ncGY370z42IT
	kUzJ7NYni/rzP5kFqioXP2dHNOjycTvrSCTWqNZ0tUzPzuFNgNGlkvWeViz6qF52fxXV3hFLldC
	Txsthh0MDHw7A76S6y0+htg8WvSgdl/aJpEGGnsrb3/FyA4BdQ99inEGp6NHGLqPkQG5WKnp81G
	Cpa7UjnJDeGVsCz
X-Received: by 2002:a05:600c:3f0f:b0:4a1:df4c:b94b with SMTP id 5b1f17b1804b1-4a1df4cbaacmr125480585e9.6.1792409463668;
        Mon, 19 Oct 2026 04:31:03 -0700 (PDT)
Received: from ERL0724PF3HPJ22.. ([2a01:599:a23:f6bd:6dd:608f:ba62:dd8f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1e7657d4dsm85435475e9.2.2026.10.19.04.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 04:31:03 -0700 (PDT)
From: Yannik Tannhaeuser <yannik.tannhaeuser@gmail.com>
To: yi.zhao@windriver.com
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-selinux][master][PATCH] openssh: restore SELinux labels for /var/run/sshd
Date: Mon, 19 Oct 2026 13:29:23 +0200
Message-ID: <20261019112923.813234-1-yannik.tannhaeuser@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807133046.423988-1-yannik.tannhaeuser@gmail.com>
References: <20260807133046.423988-1-yannik.tannhaeuser@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Oct 2026 11:31:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5095

Hi Yi Zhao,
 
please let me know if you have any suggestions for improving the commit.
 
Thanks,
Yannik

