Return-Path: <michael.opdenacker@rootcommit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849F2D6E2D1
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 17:49:28 +0000 (UTC)
Received: from lightcyan.cherry.relay.mailchannels.net (lightcyan.cherry.relay.mailchannels.net [23.83.223.105])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2717.1766080164016641329
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Dec 2025 09:49:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@rootcommit.com header.s=hostingermail-a header.b=Ssh8zkkN;
 spf=pass (domain: rootcommit.com, ip: 23.83.223.105, mailfrom: michael.opdenacker@rootcommit.com)
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 25A5E461626;
	Thu, 18 Dec 2025 17:49:23 +0000 (UTC)
Received: from fr-int-smtpout19.hostinger.io (100-103-179-169.trex-nlb.outbound.svc.cluster.local [100.103.179.169])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 34D674615DD;
	Thu, 18 Dec 2025 17:49:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1766080162;
	b=l6sOn5xkK5qLxgGe3HGxQy1b4FQ5RScfzXl+CtpyafQvPLwD092/9EhB9bJSoU6dEk4Z/q
	Of9F6MY/fRfKwDA5z8ULPpQQM1OYA7L6I4kWZ8whvimfwUAfZKjPNdwtq/hl57iqMhSUKe
	cTVf+1E0ojOrRHSyVweK0IV9nT2jBNuRK+TFONXHQLE+j/nlNMXQMneQ00rtaRHH9FWXVF
	G4xTdTBwcoQRC0M3dCdKXe2kHhS2/i0A5HxH70HnAIP3XMa/SnVzhnYTqHnzqi0QYrEVL3
	9u295fjmVHSHpVSwN2aNS6K71YQhl1SwVJhYgp3XtGPHrl8gN9RRmcmveKlsYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1766080162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=SULkTxorCC1uo6lLd+YEvlpq+y9EhngpGLlWv+t68Sw=;
	b=VW2FkYUJNhSscaOyjgKOb+6H9QElqsV1Nx57ACzDOnFsD+rIN6+VkL2xn1a4AMHyjsQa2w
	VeLS0i8YknbheqNHqkKyHUMkKNJ28D8z7VyX911T6tWn95q3UHf6nZm9MWTBr05oTUREvX
	iOu6hArotdEWzqhME/LcdKs/SWhSrPtV1d41mlcIYvi3onyCJWwXMiFQOS3UthR431gn47
	Yy0/eKaBLy1mpUwm89D8OVkoHEW0G1x5i/9fZL9DD9gWUFCWC5vtZD9216uZ1MHe3X9/Nt
	qF8hSosfiLDMaL2mso7Cadff5RwM9QISP4RT4TdXSto26SoxWWEPFkp/xmRscg==
ARC-Authentication-Results: i=1;
	rspamd-659888d77d-wj8ff;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Good
X-MailChannels-SenderId: 
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Wipe-Cooperative: 44dcf6732efe0c6c_1766080162921_2207145543
X-MC-Loop-Signature: 1766080162921:1151458178
X-MC-Ingress-Time: 1766080162921
Received: from fr-int-smtpout19.hostinger.io (fr-int-smtpout19.hostinger.io
 [148.222.54.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.179.169 (trex/7.1.3);
	Thu, 18 Dec 2025 17:49:22 +0000
Received: from [IPV6:2001:861:4450:d360:2fca:1d5c:37d3:f484] (unknown [IPv6:2001:861:4450:d360:2fca:1d5c:37d3:f484])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4dXJ8026Jyz1xy6;
	Thu, 18 Dec 2025 17:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1766080160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SULkTxorCC1uo6lLd+YEvlpq+y9EhngpGLlWv+t68Sw=;
	b=Ssh8zkkNDukMdw1lHdgxKgcuFLISsB1/EUwv+xkP2eBN3FhYYD3BushscekLdGmvCO6k3C
	vFXh5ZXBvAAX2MpGT0BjRB0UPmFYvOhxrqA2Vi0loYD0l0ktuBsvtrxeAYIvpQVd7JXOBQ
	HRu/uymGNyfP8XI5h71QjvQq62XWzO1ugf4FLPokP4J5Ct1o00eHZJPXapqpVfslCgs9jK
	/Fwpa+jWLk4EzjBSAOVQyDj+HYdfC6qlTeLT7sV013QX/zeQIe9QCZRGC/ehX1Zj6pdTAq
	6OedduWj6v1mqijqgZbBjhm0SFd9K581UOMR7bOe8GqygVIMKFobSyHcyVoe9Q==
Message-ID: <0f6cbcc3-692a-404e-91a1-8050ac4c91f3@rootcommit.com>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@rootcommit.com,
 Alberto J Rodriguez Gallego <alberto.rodriguez3153@ctag.com>
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] README: update patch
 submission guidelines URLs
To: yocto-patches@lists.yoctoproject.org
References: <20251218154226.25915-1-alberto.rodriguez3153@ctag.com>
Content-Language: en-US, fr
From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Organization: Root Commit
In-Reply-To: <20251218154226.25915-1-alberto.rodriguez3153@ctag.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 18 Dec 2025 17:49:20 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=GbNFnhXL c=1 sm=1 tr=0 ts=69443ea0 a=6pQA8W8390ihHBFSLlANeQ==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Q4-j1AaZAAAA:8 a=iGHA9ds3AAAA:8 a=d70CFdQeAAAA:8 a=FFkgmYw9AAAA:8 a=76Ts9MRf5ja1FAmoRfgA:9 a=QEXdDO2ut3YA:10 a=4Nl5AD_bsvwA:10 a=OTcYwggfWE8A:10 a=5pW4Ghl37FgA:10 a=9H3Qd4_ONW2Ztcrla5EB:22 a=nM-MV4yxpKKO9kiQg6Ot:22 a=NcxpMcIZDGm-g932nG_k:22 a=68zX3NBONfhrjPsQbRng:22
X-CM-Envelope: MS4xfAF2M8dKf1gBr6Zd2Xv49FxNskkg/XXxpMCYS4K0hzVX5du1YKSBuFlG9si4oaLy7XXY6L+MbluR4xjJIWuqkWsoRgQC/LTmJ1A8Zo82yOEuNrwBXscB LgdlROv5ZDXOXvsidLMSzXhkP+p7wxmbPyTe5hY1d77o+/kbt4W396QylqM63uPgPZP84hq7xu1pB9bfdoSVEY1dZeIc06X1SlFpGSn+23ncOFlOj2yoYipi KYmcFINZjMk6UW+dXTYQieY68jtEyWMZBQTVrm3rJnU4kZe0/hEdTS0GdMFzfcuo2QhhSEI9H4jnhseOmzO4Dt2YpsJqk1YUMI7BzjdFb45Q+/Npq25nUpQP vvNQ0TtN+41zPkt4eB8MRFPFRz5K4YZ5y0habqqBcMo5mW3rVevaNERKXKRBUw51TCfzT0k91MPjSn/j18s9SMd4N1h+YA==
X-AuthUser: michael.opdenacker@rootcommit.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 18 Dec 2025 17:49:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2817

Hi Alberto

On 12/18/25 16:42, albertoj.rodriguez.gallego via lists.yoctoproject.org 
wrote:
> From: Alberto J Rodriguez Gallego <alberto.rodriguez3153@ctag.com>
>
> Signed-off-by: Alberto J Rodriguez Gallego <alberto.rodriguez3153@ctag.com>
> ---
>   README | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/README b/README
> index c1d5d4c..c2697d1 100644
> --- a/README
> +++ b/README
> @@ -251,8 +251,8 @@ Maintenance:
>   	When sending patches, please make sure the email subject line includes
>   	"[meta-rockchip][PATCH]" and follow the community's patch submission
>   	guidelines, as described in:
> -		https://www.openembedded.org/wiki/Commit_Patch_Message_Guidelines
> -		https://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmbedded
> +		https://docs.yoctoproject.org/dev/contributor-guide/recipe-style-guide.html#patch-upstream-status
> +		https://docs.yoctoproject.org/dev/contributor-guide/submit-changes.html
>   
>   	This can be configured within the repository with the following commands:


Good catch! It was time for this update :)
Reviewed-by: Michael Opdenacker michael.opdenacker@rootcommit.com

<mailto:michael.opdenacker@rootcommit.com>Thanks!
Michael.

-- 
Michael Opdenacker
Root Commit
Yocto Project and OpenEmbedded Training course - Learn by doing:
https://rootcommit.com/training/yocto/


