Return-Path: <yannik.tannhaeuser@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB4AC79F80
	for <webhook@archiver.kernel.org>; Fri,  4 Sep 2026 16:50:13 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2790.1788540609639048695
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 04 Sep 2026 09:50:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=p049qXgu;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: yannik.tannhaeuser@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b8eeb3ff2so11507005e9.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 04 Sep 2026 09:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788540608; x=1789145408; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GXYb4ff9pJvESl+Kav+CSv+hal8TL5PkFJIpk6ZO354=;
        b=p049qXguuTPgzJOYZds1Gu3VlIpdHKsIqZSngDxZA5lwYpLcMiOIt1L6NiACL7ht/g
         +k+I5KaMev93xggy7m7jtJbh/uaw1Q+fAKDYEplFuUKAhQx2m1xOeHldG/UuvgaoM3fS
         DlKOYI1Hxmn7V4QqAbsOXRlTRN/y/zYebsYDib/Ny7G7aiEjIxe7BSJOXzWrzfMkg33Z
         wgOmYelmJPE++ilYxPwHtIWsrNgly2WwOpjMft5WU7Y4oknp8O91hGjz+asXEnRFz6Jy
         BgOKE/EtRpkS99yBCQdmQzrnnof3MMgWonlvqQNQzTv154kxsqyU0R5cWSNaNdef9y7q
         xkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788540608; x=1789145408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GXYb4ff9pJvESl+Kav+CSv+hal8TL5PkFJIpk6ZO354=;
        b=EWiAWomCS9AxShM4501weKa2pSk5m9eR5GSA3RYiOnK5g1wq1weGeUy+n2aFBi0GlF
         ltWnk+TPkrrOvtXua+v/C8yU+m1XE1qOcVedtJ22DycbEih8zhMrtFwK1EA4ixCrzMCV
         bsP8DtnD5ShzRAI78b01UOAIDa28iEnRCIAuhLTfuxj9sHaZD3yc2OsqNKfdmyyI737F
         daz9poKGOZvPBrPxtkTSIlg5eD6Mp4QO8RaaD4bfwjzxLiqsKeLTWdLve4DylISh6w2u
         jsVZ0ORoV/gAvHzwy/MjbC8pPpglsbfdC0x+0UVCCoWdHGw16EXmP0EfX2Mw0Z6SSUnh
         2bdw==
X-Gm-Message-State: AFuF++mpEA62S7QhyJLqGQfZdbwvFkuVXgAUaw/9W3eDXiiUG53KM1yN
	Ea+c2vX+5VKM0VwdVLRiXn0eWhZ56E+YG5SgGXwWfxxhmzJC2KXktdnD76tDSw==
X-Gm-Gg: AYBFou2T65Cpj++ZTD3FQE0wyGE74iz+2l/e1OTW1Pn6m3znSe2LI8d6iq78q7XQyvH
	XytFb69zZyUjc1Fxey41xGGhXMASgBCm1XXH0Rn4L3tO71aoQDhOSIK6sPuduoCotPjEitrUFvw
	O89Z/jP6jmM2OVyJ8qDa7sR7M41RkO+QPuaot/6ET9FKUYbpziHJQ52V/Hj2LQzoxTgllOVk+0y
	oDd9GsNeRwkBRGkFdGBZKJXXoKD6573F2Ab5z/HaC52hWkRTVfXItMres9lFYm2YdhP9zme6fsx
	dSamkJthL/mSUSZouc2iUWugWsRSz6a9kocHDo96ohV7nGMyNtmjnnjKTL05eEx4nCnOb/ZEwb2
	ax7jezezs6WBqaTXMNhuZKO9OJOBNQbsxld4a88ew2qmixgQbuEg6JJlbuvrlMSuwiDAC85nRAk
	TbBwFYSZBBWovFp7WxnlQskJ6PvBQ3W6pcW7fcAS9VxEzLRo8iCAomlCTvkMnh3sw/SDQCRLLMQ
	gcQVWBAFu1mqeA59dVlzxvMhnYuby84vLM3Fw9eTxuWg4kejv5GVGQ3EBghkWZmSfhLZgkL4wAW
	jhI=
X-Received: by 2002:a05:600c:8b05:b0:499:9240:9a1c with SMTP id 5b1f17b1804b1-49cf82787camr74781565e9.15.1788540607622;
        Fri, 04 Sep 2026 09:50:07 -0700 (PDT)
Received: from ERL0724PF3HPJ22.fritz.box (p200300f847017a009ce9fbcb9cba4fab.dip0.t-ipconnect.de. [2003:f8:4701:7a00:9ce9:fbcb:9cba:4fab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee3b0af8sm170588935e9.0.2026.09.04.09.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 09:50:07 -0700 (PDT)
From: Yannik Tannhaeuser <yannik.tannhaeuser@gmail.com>
To: joe.macdonald@siemens.com
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-selinux][master][PATCH] openssh: restore SELinux labels for /var/run/sshd
Date: Fri,  4 Sep 2026 18:49:12 +0200
Message-ID: <20260904164959.632803-1-yannik.tannhaeuser@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2064468.1787219475342773998@lists.yoctoproject.org>
References: <2064468.1787219475342773998@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Sep 2026 16:50:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4735

Hi Joe MacDonald,
 
please let me know if you have any suggestions for improving the commit.
Or if you are not interested in taking this commit.

Thanks,
Yannik

