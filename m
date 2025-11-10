Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D3BCCF9E3
	for <webhook@archiver.kernel.org>; Mon, 10 Nov 2025 10:19:33 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.45141.1762769966262449412
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Nov 2025 02:19:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dz7eQAo2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47117f92e32so24572315e9.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Nov 2025 02:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762769964; x=1763374764; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UwQ7FGfwAK0DOg5vVDQ1x7/rXu3IUeI933fIeFBbWQo=;
        b=dz7eQAo2H3VlR2/PdJntmvQrSy9EldTlsF+NAAYfdNBYqYumW9KIA811IwJrY+3OK1
         dqnpZGrgJpWk9QCBMgmrfl5TPAuw+TyxOD3IrU8ViOm42QCcQJYBl6Hv5SReAy4o22rX
         wzuJhbpqMMYzwl93osOaUY+ke6W/m+BPjczxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762769964; x=1763374764;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UwQ7FGfwAK0DOg5vVDQ1x7/rXu3IUeI933fIeFBbWQo=;
        b=O18h22ORAA3Rvt4+amPFhMbT+t3ZyH+mUMYtBige8bc5AEKge3bArcPiyJh5rJAxEM
         HB/bS2v8rONtUdR+T5NPakPVFEWEXP3q/MtuVOPDvFThpp44KYg3vRFWFcZQDrd6QIGH
         PCx8Ae/nb7sNGgXpKgUKd5YhnrIJzkfY+g5XbYwjidKbv59mWN9ewKh1areoBsKwR+Eg
         wIaMyhjhGQG0tVdc2aYLL6OhuiLYw+q+5+dy6S+eGkyoCrHPhKw71fhY5MWIC0HLs1hy
         H6c/EeWHKGp/KtSunzeZo248keSeOFPlocsgM8dJ6ig+r2jxvXLmWhG12fBKA7JZvPgz
         DIEQ==
X-Gm-Message-State: AOJu0YyKm+0hyiklldcHt1K0WKoWrSgv5ETkRPOtP9yw6vXCkH+dRGk9
	dnjM+1+pBwey/P4W8HbEjpfK/ijms3s3hwgB10ApS8josxWJPvbjkqbOSTcj2Yu8sO3YjulQcXy
	ovjYR
X-Gm-Gg: ASbGnctTI6m9tn36OvxcRbqtxhLnPp6xFNmCh6gnucPSh8leuNmlWcPUgWbzMOIK3xZ
	xTp59ZdkxQevqa6owPzP2QdgY0xfGGO/dRBI5clCaCzFlmRiumhRZkej0VM/hbNKj+i4hBq1Bq+
	emzMw6r4TRtrfVmQhGxjVSXITlNRTd7iiNTOIFSR7AeRzyNr8POP8OtwAKFOoWo+nYkO7+WG9H6
	5knBp0oZdh/DPNPdttIN6ai4zudMSB5a+8GiS3LLWVsdnTQk0II/9ICMSOdhwBCBHUHwXajIcRU
	9jQX+G1SiufFCXU62h1zNKZhr9Z5DPzX5O7c0Loox9SqIJ/aMY/3Ru36z3uiXU+ph+jca50uxZh
	BnXNZAY0dwZ3D+dfgzYj/CreJywQ2dOZvqCrZ17lxQ7G/FO3j+0C3Y/kmvE8Z4g0fxk8PLdABDs
	kD6f/EkIgwpoHwt61nudBqv01Psq3vDDkTOa+kd8c8aLst8LmUV2Ip8d3M4bQW6iE1ZzZXCU3IE
	7rpktYo/m2v/A==
X-Google-Smtp-Source: AGHT+IFOeeRFfZvEx6K1A0N6OQCLQfUwKX/iaj0XItwGfm0ZHtX8efMrO8kIFifQmCY3m5XMYUULBA==
X-Received: by 2002:a05:600c:a05:b0:477:54cd:202e with SMTP id 5b1f17b1804b1-4777322eeb2mr67168325e9.2.1762769964200;
        Mon, 10 Nov 2025 02:19:24 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:ec3b:58b3:3d18:55e2? ([2001:8b0:aba:5f3c:ec3b:58b3:3d18:55e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4777bbb8cf3sm23774825e9.15.2025.11.10.02.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:19:23 -0800 (PST)
Message-ID: <11d919ae2d616270e581eb8fe45b6b998d883a1b.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [PATCH yocto-autobuilder2] reporters: swatbot:
 Fix branch name retrieval
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Mon, 10 Nov 2025 10:19:22 +0000
In-Reply-To: <DE4XNUKMV1P0.2W00O0VLX0KVJ@bootlin.com>
References: <1863DFD4C9467C5A.10180@lists.yoctoproject.org>
	 <DE4XNUKMV1P0.2W00O0VLX0KVJ@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Nov 2025 10:19:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2473

T24gTW9uLCAyMDI1LTExLTEwIGF0IDExOjEyICswMTAwLCBNYXRoaWV1IER1Ym9pcy1CcmlhbmQg
dmlhCmxpc3RzLnlvY3RvcHJvamVjdC5vcmcgd3JvdGU6Cj4gT24gV2VkIFNlcCAxMCwgMjAyNSBh
dCAxMDo1MiBBTSBDRVNULCBNYXRoaWV1IER1Ym9pcy1CcmlhbmQgdmlhCj4gbGlzdHMueW9jdG9w
cm9qZWN0Lm9yZyB3cm90ZToKPiA+IFRoZSBzd2F0Ym90IHJlcG9ydGVyIHRyaWVzIHRvIGdldCB0
aGUgbmFtZSBvZiB0aGUgYnVpbHQgYnJhbmNoLAo+ID4gdXNpbmcKPiA+IHRoZSAiYnJhbmNoX3Bv
a3kiIHByb3BlcnR5IG9mIHRoZSBidWlsZC4gU29tZSBidWlsZGVycywgc3VjaCBhcwo+ID4gImRv
Y3MiLAo+ID4gZG8gbm90IHVzZSB0aGUgcG9reSBnaXQsIHNvIHRoaXMgcHJvcGVydHkgaXMgbWlz
c2luZy4gQ3VycmVudGx5LAo+ID4gdGhpcwo+ID4gcmVzdWx0IGluIGEgbm9uLWZhdGFsIGVycm9y
IG9uIHRoZSBidWlsZGJvdCBjb250cm9sbGVyLCBidXQgdGhlCj4gPiBidWlsZAo+ID4gZW50cnkg
aXMgbm90IGFkZGVkIHRvIHN3YXRib3QuCj4gPiAKPiA+IEltcG9ydCBjb2RlIGZyb20gc3dhdHRv
b2wsIGZhbGxpbmcgYmFjayB0byBvZWNvcmUgb3IgeW9jdG8tZG9jcwo+ID4gYnJhbmNoCj4gPiBu
YW1lLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXRoaWV1IER1Ym9pcy1CcmlhbmQKPiA+IDxt
YXRoaWV1LmR1Ym9pcy1icmlhbmRAYm9vdGxpbi5jb20+Cj4gPiAtLS0KPiA+IMKgcmVwb3J0ZXJz
L3N3YXRib3QucHkgfCAyMCArKysrKysrKysrKysrKysrKysrLQo+ID4gwqAxIGZpbGUgY2hhbmdl
ZCwgMTkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEv
cmVwb3J0ZXJzL3N3YXRib3QucHkgYi9yZXBvcnRlcnMvc3dhdGJvdC5weQo+ID4gaW5kZXggNWU0
MzRkNWQwNGE0Li42ZTM4MjczMjkwMzMgMTAwNjQ0Cj4gPiAtLS0gYS9yZXBvcnRlcnMvc3dhdGJv
dC5weQo+ID4gKysrIGIvcmVwb3J0ZXJzL3N3YXRib3QucHkKPiA+IEBAIC00OSw2ICs0OSwyNCBA
QCBjbGFzcyBTd2F0Qm90VVJJKG9iamVjdCk6Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIHNlbGYuY2xpZW50LmdldChxdWVyeSwgdGltZW91dD1zZWxmLlRJTUVPVVQsCj4gPiBo
ZWFkZXJzPXNlbGYuaGVhZGVycywgYWxsb3dfcmVkaXJlY3RzPUZhbHNlKQo+ID4gwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gcmVxCj4gPiDCoAo+ID4gK8KgwqDCoCBkZWYgZ2V0X2J1aWxkX2JyYW5j
aChzZWxmLCBidWlsZCk6Cj4gPiArwqDCoMKgwqDCoMKgwqAgIiIiRXh0cmFjdCBicmFuY2ggbmFt
ZSBmcm9tIGJ1aWxkIHByb3BlcnRpZXMuCj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqAgQXJnczoK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJ1aWxkOiBCdWlsZCBkaWN0aW9uYXJ5IGNvbnRh
aW5pbmcgcHJvcGVydGllcwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgIFJldHVybnM6Cj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCcmFuY2ggbmFtZSBpZiBmb3VuZCwgTm9uZSBvdGhlcndp
c2UKPiA+ICvCoMKgwqDCoMKgwqDCoCAiIiIKPiA+ICvCoMKgwqDCoMKgwqDCoCByZXBvcyA9IFsn
cG9reScsICdvZWNvcmUnLCAneW9jdG8tZG9jcyddCj4gPiArwqDCoMKgwqDCoMKgwqAgZm9yIHJl
cG8gaW4gcmVwb3M6Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmFuY2ggPSBidWlsZFsn
cHJvcGVydGllcyddLmdldChmJ2JyYW5jaF97cmVwb30nKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaWYgYnJhbmNoOgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm4gYnJhbmNoWzBdCj4gPiArwqDCoMKgwqDCoMKgwqAgYnJhbmNoZXMgPSBbcCBmb3IgcCBpbiBi
dWlsZFsncHJvcGVydGllcyddIGlmCj4gPiBwLnN0YXJ0c3dpdGgoJ2JyYW5jaCcpXQo+ID4gK8Kg
wqDCoMKgwqDCoMKgIGxvZy5lcnIoIkZhaWxlZCB0byBnZXQgY29ycmVzcG9uZGluZyBicmFuY2gs
IHBvc3NpYmxlCj4gPiB2YWx1ZXM6ICVzIiwgYnJhbmNoZXMpCj4gPiArwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIE5vbmUKPiA+ICsKPiA+IMKgwqDCoMKgIGRlZiBmaW5kX2J1aWxkX2NvbGxlY3Rpb24o
c2VsZiwgYnVpbGQpOgo+ID4gwqDCoMKgwqDCoMKgwqDCoCBkYmlkID0gTm9uZQo+ID4gwqAKPiA+
IEBAIC03Nyw3ICs5NSw3IEBAIGNsYXNzIFN3YXRCb3RVUkkob2JqZWN0KToKPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJ2F0dHJpYnV0ZXMnOiB7Cj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgImJ1aWxkaWQiOiBj
b2xsZWN0aW9uX2J1aWxkX2lkLAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICJ0YXJnZXRuYW1lIjogYnVpbGRbJ2J1aWxkZXInXVsnbmFtZSddLAo+
ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgImJyYW5j
aCI6Cj4gPiBidWlsZFsncHJvcGVydGllcyddWydicmFuY2hfcG9reSddWzBdLAo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgImJyYW5jaCI6IHNlbGYu
Z2V0X2J1aWxkX2JyYW5jaChidWlsZCkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiA+IAo+IAo+IEkgYmVsaWV2ZSB0aGlzIHBhdGNo
IHdhcyBuZXZlciBtZXJnZWQsIGFueSBvcGluaW9uIG9uIHRoZXNlIGNoYW5nZXM/CgpTb3JyeSwg
aXQgaGFzIG5vdyBtZXJnZWQuCgpDaGVlcnMsCgpSaWNoYXJkCg==


