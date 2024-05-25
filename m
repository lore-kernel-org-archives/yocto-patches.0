Return-Path: <beroset@ieee.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8C0C25B78
	for <webhook@archiver.kernel.org>; Sat, 25 May 2024 21:26:18 +0000 (UTC)
Received: from cordonneriepedica.ca (cordonneriepedica.ca [64.118.86.28])
 by mx.groups.io with SMTP id smtpd.web10.6161.1716672368478962808
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 25 May 2024 14:26:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@beroset.com header.s=default header.b=b9HEgydD;
 spf=permerror, err=parse error for token &{10 18 _spf.google.com}: parse error for token &{10 18 _netblocks3.google.com}: limit exceeded (domain: ieee.org, ip: 64.118.86.28, mailfrom: beroset@ieee.org)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=beroset.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yj4UbUGv1JEQpAOB6dv2sexm4BNUBl+X2VEjUyNOHtM=; b=b9HEgydDAvlA4jSz4zsHzkxTlt
	xwhIIJlmJOe1o2mk8PtnMtTTEKIQrOQUDuo+UPEZ/H3VCBrWgaYW5xxKi4OhfP0cQo5MTQSHxjpkv
	SGX8fwtgJ4WvIHhAy6EKTXPLTU6LknRs8qkKiRdhgfesH49BBLoebJ/R8ttDV4S1ofnRPuifbvYzZ
	zDUC1XU10GjZk+RaeneMeL92FZR3lM7aehNJUsZYZ4C56jOgmnZPcMuGkv7CNy8ShqI5cGwC7ZRlX
	DxJ3Yjj3x2HuNSaEx4tBwk/vaHBRIqO7m0MlwTrgzfKoRrooGDSDyvPUcjiiMEck6XuTxAGva+TDZ
	YrTAiHQA==;
Received: from 104-185-76-86.lightspeed.rlghnc.sbcglobal.net ([104.185.76.86]:35252 helo=[192.168.1.213])
	by drive300.trustyservers.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.97.1)
	(envelope-from <beroset@ieee.org>)
	id 1sAyu2-0000000DF5U-2lKd
	for yocto-patches@lists.yoctoproject.org;
	Sat, 25 May 2024 17:26:07 -0400
Message-ID: <eacb16f2-0ec1-4bae-a345-416673f2bb97@ieee.org>
Date: Sat, 25 May 2024 17:26:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org
From: Ed Beroset <beroset@ieee.org>
Subject: sorry for spamming the list
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - drive300.trustyservers.com
X-AntiAbuse: Original Domain - lists.yoctoproject.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - ieee.org
X-Get-Message-Sender-Via: drive300.trustyservers.com: authenticated_id: eddieieee@beroset.com
X-Authenticated-Sender: drive300.trustyservers.com: eddieieee@beroset.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 25 May 2024 21:26:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/196

I apologize for the half-dozen duplicate messages.  I was having a 
difficult time configuring git to send email and didn't realize the 
messages were actually getting delivered.

Ed


