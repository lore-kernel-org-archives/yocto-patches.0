Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.122])
 by mx.groups.io with SMTP id smtpd.web11.14072.1713777821392646723
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Apr 2024 02:23:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnNxKJxdgywlnwsFy9kenNxHnvFU8Ir8GNHtXIY2sPg=;
 b=epsSeaScTobtHh5BB/RqJUqmWgfbp277eZGn0CAvnqo54W1AtRIW9p9lLpPoj05APfbqqX/NRWH10AlzCxi9Oc6tyy5RwUU4E6Qjtx3ptugx1cY9kh2U9f1aIEj4is+j11eN8+X22yE2wwDrWmuv8K/qqF3LyhUnevSZb1yC4Xxlm768i5xUqL1ZYAjatXD+9FCJcnhBlogObKIcOLtJtS3J0ykXtnNm7kBdtqMKFcC4uH8IWnKRlI7LqvEOsmq1H/Mclw6UwsyBPuHxTFoC2PWLyLbwY8NNKfsW2CxA9XRMsw+qfRXUv5ENU02mSjVsKylqYnElfVvaRFlQ5olY5g==
Message-ID: <7899a171-eb32-464a-8f74-7b730ca38ce1@theobroma-systems.com>
Date: Mon, 22 Apr 2024 11:23:32 +0200
Subject: Re: [yocto-patches] [Poky] Do install append to mesa does nothing in scarthgap
References: <0qeE.1713652756483185891.Q3Ak@lists.yoctoproject.org>
 <9744.1713652881983262652@lists.yoctoproject.org>
From: "Quentin Schulz" <quentin.schulz@theobroma-systems.com>
In-Reply-To: <9744.1713652881983262652@lists.yoctoproject.org>
Return-Path: quentin.schulz@theobroma-systems.com
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: yocto-patches@lists.yoctoproject.org
List-ID: <yocto-patches.lists.yoctoproject.org>

Hi Joseph,

Good catch, can you please send a patch following our process?

https://docs.yoctoproject.org/contributor-guide/index.html let us know 
if you have questions.

The change seems to be merged into mesa 22.3.0 and 23.0+, c.f. 
https://gitlab.freedesktop.org/mesa/mesa/-/commit/96894e6746c199cb8a5b8356f75c2ee8f28e68b1

So I think this means we should backport this to Mickledore and Nanbield 
as well, according to the versions reported here 
https://layers.openembedded.org/layerindex/recipe/5605/.

Thanks,
Quentin

On 4/21/24 00:41, joseph.mills via lists.yoctoproject.org wrote:
> You don't often get email from joseph.mills=cnhind.com@lists.yoctoproject.org. Learn why this is important<https://aka.ms/LearnAboutSenderIdentification>
> 
> Edit
> 
> 
> 
> Upstream (scarthgap)
> 
> https://gitlab.freedesktop.org/mesa/mesa/-/blob/mesa-24.0.2/include/EGL/eglplatform.h?ref_type=tags#L112
> 
> 
> 
> Upstream (kirkstone'ish)
> 
> https://gitlab.freedesktop.org/mesa/mesa/-/blob/58ad6e52d1983785e951726f6940aa30e46bc462/include/EGL/eglplatform.h#L125
> 
> 
> 
> 
> 
