Return-Path: <michael.opdenacker@rootcommit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648DECF8842
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 11:03:35 +0000 (UTC)
Received: from panther.cherry.relay.mailchannels.net (panther.cherry.relay.mailchannels.net [23.83.223.141])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31593.1763636606655955469
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Nov 2025 03:03:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@rootcommit.com header.s=hostingermail-a header.b=XmuyFvH5;
 spf=pass (domain: rootcommit.com, ip: 23.83.223.141, mailfrom: michael.opdenacker@rootcommit.com)
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0553F1210EA
	for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 11:03:26 +0000 (UTC)
Received: from de-fra-smtpout3.hostinger.io (trex-green-9.trex.outbound.svc.cluster.local [100.127.179.109])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 0C36512188A
	for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 11:03:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1763636604;
	b=uOZHIinfdvb40V6xLCNSmu696qxG/dXecstZ0rma+I+oze5HJXSsFw4L1sohr69S/uRM6d
	eW4Ws2AAJ/JsGvcvi946ZBRw8tDyrknyug+x3La1uTqLs3vK1nxWQeQOkmKZ4lKy2goQzV
	OtE7e4Qq8WN23oZYOHJQWhO3MgYdU7j2xviwz+XdpX7XGbVSPuWnPhQ/KeWw8eYVg4scxj
	0/kcr+DAK5tStXyrYv/immjOQr3G7lTStnoEj6QyCU88pI0eW+7FhM6wrVH6Ua1YvteMUV
	5FfJdDOyj+scRA4c6IjpZ3jPHj7FlcxZh5SEq1CweE9240y22B19KrBV9KBGFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1763636604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=egXNovtmuqry9aj1DyhtpP3q2tQSfI2+ePYLPtaOB9E=;
	b=Ripgg0VPF054lpZov9pFWeS3gwEBIPl02MZD0Gk1ssCS4xHlsQJsxwBJNdUh4GFMXclxTD
	SmtJk1T/k6PcJOqP3s/sfPjF3jrlCt8u8DFi+byZrybGg/L86InVIG4pui60zTN1Wt9ipK
	Dyhtr0q09HqwRN6wKcs1iUeqEJsFOX4hhnEAl8zHDTGOcF1OTro3BQLmnLGAqhvqU53plS
	3g6d0nAhck7J2CYVTesv0Yjbu1g0RovehKLRwBb7+fxzfRSAXhp4LpOhLuqYSsux200rWU
	5Qf/QTByD6W4z+zoR9Ch56Vgttyo6ZgHZ1mRJ4kMWKQQ0QC1tVx4E97oFDPt/Q==
ARC-Authentication-Results: i=1;
	rspamd-55b59744f-9n86x;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: 
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Lyrical-Power: 359e165c2e775c01_1763636604570_1466888559
X-MC-Loop-Signature: 1763636604570:1914773761
X-MC-Ingress-Time: 1763636604570
Received: from de-fra-smtpout3.hostinger.io (de-fra-smtpout3.hostinger.io
 [148.222.55.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.127.179.109 (trex/7.1.3);
	Thu, 20 Nov 2025 11:03:24 +0000
Received: from [IPV6:2001:861:4450:d360:a066:6d43:e556:60e2] (unknown [IPv6:2001:861:4450:d360:a066:6d43:e556:60e2])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4dBwSV1FWDz3x6f;
	Thu, 20 Nov 2025 11:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1763636602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=egXNovtmuqry9aj1DyhtpP3q2tQSfI2+ePYLPtaOB9E=;
	b=XmuyFvH5U9U9GYrjG0wltkXIS5OmpsestF0iHnu3nKGV27xmrgzoGJNn6YnbUKs0obBCgV
	Ng87W8G1/mibROvFyKMfWJtzozGOrnaj20kt4FtQDdSe4wy/QendCmVz76TVSi5WmTh4Rt
	ANuXMru59HFXR5SvABxVhfLKe7xhUn+fi3CqTAvSvHlpt58NQk2D8JbiqYtqUYImO58h3m
	7OvwEST1fTSZVcbnwjHEhsTHkiDmoHVv5bP6cppak3qf8n1PLPXsQ0Ks/atzsbeGVLz0HG
	7XzjvkR8/w/zmuun61acovIFyYnPFkt+Jv32kh6gQeYFGxvlUyoUqk7JO+NVKQ==
Message-ID: <048c6ea4-e7cc-4650-8f0f-b85ef961914f@rootcommit.com>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@rootcommit.com
Subject: Re: [yocto-patches] [PATCH meta-rockchip] orangepi-3b: add
To: yocto-patches@lists.yoctoproject.org
References: <1879B0158049C4B6.1423420@lists.yoctoproject.org>
 <f176e971-d19f-47a1-a591-d2a501d16079@rootcommit.com>
 <58102c94-8c32-450a-bccf-1edd16bbad3f@cherry.de>
Content-Language: en-US, fr
From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Organization: Root Commit
In-Reply-To: <58102c94-8c32-450a-bccf-1edd16bbad3f@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 20 Nov 2025 11:03:21 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=ALriHGRn c=1 sm=1 tr=0 ts=691ef57a a=l2urqJcD81kOlpy6CkxEZg==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=d70CFdQeAAAA:8 a=iGHA9ds3AAAA:8 a=FnV5fwCJXuL6rIWBNa4A:9 a=QEXdDO2ut3YA:10 a=NcxpMcIZDGm-g932nG_k:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-CM-Envelope: MS4xfNpMs+YzSf5GvZM+VGElm9unvCmRtPnBB0m3UtV/CNO4fiNzQyZR9YfyAEIgknhnV3bZRMT8v1XKI4tQqkrNRjw2hWL0IXDLNwH1MplBBpS/lUWnA9rO nMbm+qQyOiIM8Wcxtk//9j11OHx1og9H0LmxTFopsusrHuo3gQIk0YoanCE2/hzWEDxOREv5YhDYMQweFlxajromMvLMGviMpUXJJEUf65QeEcHZmxVh9V5k gVlmzFUxgsVGRhs1TNS6A1JF9ial6FQwtcU3xR0xQWGcphZWCFo8BzXQQ6ikHmbkh55gbt48IgjtsafobojiFoDM5ev2Zz6Ey8HLO8EjyWoeFXozZydDJvcY gx2o/L6SF/8VxE9dJFIqIx+0bd1cjX2I6QlmHx9asxszGZX8r0o=
X-AuthUser: michael.opdenacker@rootcommit.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 11:03:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2625

Hi Quentin,

On 11/20/25 11:40, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Michael,
>
> On 11/20/25 11:34 AM, Michael Opdenacker via lists.yoctoproject.org 
> wrote:
>> Oops, it seems b4 messed up the subject line.
>> It should contain "[meta-rockchip][PATCH]"
>>
>
> All my patches sent by b4 have the same pattern as yours. Glancing at 
> b4's code, I believe this is how it's intended to work, c.f. 
> get_rebuilt_subject() in src/b4/__init__.py
Good to know. So, it's not too bad.
Thanks for your reply!
Cheers
Michael.

-- 
Michael Opdenacker
Root Commit
Yocto Project and OpenEmbedded Training course - Learn by doing:
https://rootcommit.com/training/yocto/


