Return-Path: <michael.opdenacker@rootcommit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F42D6E2DC
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 18:29:43 +0000 (UTC)
Received: from quail.birch.relay.mailchannels.net (quail.birch.relay.mailchannels.net [23.83.209.151])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.844.1766082582856591347
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Dec 2025 10:29:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@rootcommit.com header.s=hostingermail-a header.b=nL6a5xKg;
 spf=pass (domain: rootcommit.com, ip: 23.83.209.151, mailfrom: michael.opdenacker@rootcommit.com)
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id EFA3F74218C;
	Thu, 18 Dec 2025 18:29:41 +0000 (UTC)
Received: from fr-int-smtpout19.hostinger.io (trex-green-8.trex.outbound.svc.cluster.local [100.102.180.166])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id E664B741697;
	Thu, 18 Dec 2025 18:29:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1766082581;
	b=Rv7VD6SSkRdFdQFL70HGicHUugmflHPoNYJtta1neDXwyJf3owEhCAszuPK5DmgYIS9c/g
	HPEG3df1PGESE9Zg2Pwcu9uChuvgLNSgXFbyhS8UyEqmSs8oq8Tc8ruO/harEeQNrZZaef
	n/hNwNM67HGJ0dcD+ih2M+Tbn/9ey7aCfvhEwYkeRp/Bho9nQW5K6K2Rr/CwI0yUVmJUWA
	JOyHLJcX8FW/2LzaPm2FR65SLWl0dytZ3xyCkP44xyClKgMS3zzp+CStTd917TGHz6ZhwY
	6YjjUxHU9Rpmzzdd6oLz57E7lWv+jzwjBEIlQRtbUgbIGLlsJPDv2mrhsnqLFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1766082581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=kG/kKjopHGNkzQoHyvBYWwDmmZpX6TPfp0xKrZDj0VE=;
	b=rjyeJ0vE7jLscLhGKn9oJ4TEpb98FZ64HaWkXf5hqt5m8gvaq3Y+CYUlHiU37wV15iVx1k
	+F3Ddpfx5FUDFz8RwSNXPZiQmANgmKIn/D4SDFLeTQwyeFDsSnmKDhwRm6Xufetey6egTT
	o6TNx2LFePqM4F0edpAulHiVuyBmfx9wfnaR9GdeOHBlnUfEZPZqo5ZvCGOgcVaitE3jxX
	/NqXVaJK++IhQxAjylbat9TBFKsxws2MRxy/FMneYpmIIJM5OpEwb4joWYFMV6FfaVHDNS
	RDOwGIxiHNqZrsG5TzLnvJvLaGgkkXOPagED7agt11XLkv58btoolq0Ewo54Sg==
ARC-Authentication-Results: i=1;
	rspamd-659888d77d-f5dfg;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: 
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Illustrious-Continue: 01fde3ab7ea935d3_1766082581633_2684504859
X-MC-Loop-Signature: 1766082581633:4283466221
X-MC-Ingress-Time: 1766082581632
Received: from fr-int-smtpout19.hostinger.io (fr-int-smtpout19.hostinger.io
 [148.222.54.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.180.166 (trex/7.1.3);
	Thu, 18 Dec 2025 18:29:41 +0000
Received: from [IPV6:2001:861:4450:d360:2fca:1d5c:37d3:f484] (unknown [IPv6:2001:861:4450:d360:2fca:1d5c:37d3:f484])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4dXK2W0Hbfz1y0J;
	Thu, 18 Dec 2025 18:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1766082579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kG/kKjopHGNkzQoHyvBYWwDmmZpX6TPfp0xKrZDj0VE=;
	b=nL6a5xKgXmpUH4YrovlYmFhA69raL4lVjwseOrcwyX121558uboOuyKa6c2UYaUVPQjS3k
	Y5NDHh4bi9BKiZwX8zjspJHKMxxfJ8hxk2zfq2d41cdYWMBmezqEmXu1xWhxzwJ8UKZBFx
	Mf7ruxcQcpXlaKWzsDEVhm63My3c28JV/FQh/giQLDDW1dIb8Mq+JafPRTVln6m8VsUbcz
	TOU72qgVEbnzbR/6D+yW+QAznPSadCe5BchtVCAWnrRk36ZUQafpHG/pkUYdL+5BKwBEYj
	Ov3B/PcZs3QjtS2JUK40kVoIJoPUxZ33v7fAgNllykODway8hHWPmeGYxoqWGg==
Message-ID: <5d7d8b88-587a-423d-836d-e331a6ab6021@rootcommit.com>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@rootcommit.com,
 Alberto J Rodriguez Gallego <alberto.rodriguez3153@ctag.com>
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] README: update patch
 submission guidelines URLs
To: yocto-patches@lists.yoctoproject.org
References: <20251218154226.25915-1-alberto.rodriguez3153@ctag.com>
 <0f6cbcc3-692a-404e-91a1-8050ac4c91f3@rootcommit.com>
Content-Language: en-US, fr
From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Organization: Root Commit
In-Reply-To: <0f6cbcc3-692a-404e-91a1-8050ac4c91f3@rootcommit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 18 Dec 2025 18:29:38 +0000 (UTC)
X-CM-Envelope: MS4xfPk/uvfyKdpoUSnd9OCH6e7Jb4ABAqdRtRl+0bx/58ehOT1SfZZL4GkwoXlR9JCUnoViPH7leeyb3xYjeZzfXewh+NbJHKsQ1SxT+oDMFKV+Eq+mMPuF vuGCLlmSwvCAEd+VNUDOTQF13DH3aHq9VlDA86ytGUqASVJNNvTdaPfqpljgXeYbg6hW8xtu4JzoRX10k87TVpcHCmtZUFi1Ls1shMIsmEGGjTe0sORTxDaZ 9wMOXb4hY01EFXZNqtYfkO+vs596XSuqPdafE3KBpoRwKCOegk2+cqRS0tp6hSraVljP1x+mgzWipFMrRqLff0G7TO4QkAmmQfqapt2TFhzoRg7MCHYTu7Hg DeDzf41ClRrJEDhyuYhD25KKbEFjiNJtDbbgHbFG/rC2m4f3K4lR1C/xBS1Nzkz0TTT0j150qbRhuC5zDNadvYhuKCLHUg==
X-CM-Analysis: v=2.4 cv=B9fr0/tM c=1 sm=1 tr=0 ts=69444813 a=6pQA8W8390ihHBFSLlANeQ==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=d70CFdQeAAAA:8 a=EFITDiKhfqrna_i7zvQA:9 a=QEXdDO2ut3YA:10 a=URPqgtl0u8oA:10 a=Qzt0FRFQUfIA:10 a=NcxpMcIZDGm-g932nG_k:22
X-AuthUser: michael.opdenacker@rootcommit.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 18 Dec 2025 18:29:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2818


On 12/18/25 18:49, Michael Opdenacker wrote:
>
> Good catch! It was time for this update :)
> Reviewed-by: Michael Opdenacker michael.opdenacker@rootcommit.com 

My apologies for the noise,, I have issues with my notes today:
Reviewed-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>

-- 
Michael Opdenacker
Root Commit
Yocto Project and OpenEmbedded Training course - Learn by doing:
https://rootcommit.com/training/yocto/


