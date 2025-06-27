Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EFCC77B7F
	for <webhook@archiver.kernel.org>; Fri, 27 Jun 2025 21:20:52 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.1741.1751059246228270778
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Jun 2025 14:20:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=BbfgY7wt;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-453398e90e9so2465435e9.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 14:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1751059245; x=1751664045; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFq1Yl8lHVCO6yrrRF/r65lEu3MJue/kxxcDnhjMKUY=;
        b=BbfgY7wtn4hY6ApWTxXQ6/dscGx3iys706QRyYfJLngH+6z0UfaauBf8P22mQXj9d6
         PxCK3rgKAZndjGJt9LyjRz4ttf6yYJR7S0kIquxnAkwp87iqi8LSbEhtj1bi5u7LVJUr
         gBBXH8SJA01rzyv+6HXp/IP2e8bilXpJZv5xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751059245; x=1751664045;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eFq1Yl8lHVCO6yrrRF/r65lEu3MJue/kxxcDnhjMKUY=;
        b=KydzMGVumg2uyY69L8I7+w8SCCpAnkzTEycISuXIOF7Tu9RikHf9M6ft1ZmJYuYHnh
         kgm5I+Ued+bpac3Sr/PkgGVi+s/JxQPDPy5VJGzHpi0GbFOnJC075Obpps0LqkgBAqdI
         1Z5F2xsyHHGUzeZQ8JMQ5tWXsqtLr3Pn9z5AS0U3MEmKUZlfsF19KWxnQN1sKIOLJK/K
         JB7Qzlnkz3aujZ8sIRpl5DrRyVxrilUywu3xTFdBwBTqu9UhrAj6EtiNX6OJ2MkzSsIv
         t6WRt8LLGVDMyhFiVsE1eq8eMCcCrEgZuowrUr+waWh6slY1rYPntpM7zNnHPkk7Yw9K
         WiPg==
X-Forwarded-Encrypted: i=1; AJvYcCU2M0+7qIY8FLvif+daIwlbo0T1iDdLdFITl+euCGEDdjVRRmmlraGvX53Q7KZ/J//YKRlmgdAeuMA5+lKu@lists.yoctoproject.org
X-Gm-Message-State: AOJu0Yz+1rJmJpH/69y4fxeWAEeE3FVJjDLKHpN3eu8ar+OyiAkerVh2
	tjfM92p+VgDbsaLS+RG5W2xeBumHtfpALgrvrdZ/lY1495M1AtKTOoWItdO24Ijstfo=
X-Gm-Gg: ASbGncvuqyheOMDF9zIz8FD9QR80GwMrm4tlVSRl1OqhYQGwA7C0hutWJk7MFFc3mze
	SB/LYH3somZvUXlPPBac+WPG5xLHTp2/VqaVk1cFbs+/7v7o97ey8s8AeZBBw2FwfIQCsNRm1cf
	fOGxyrPiJiWIWTMQFWMy7G7D0I9zex9bEmjJ+z5RZR18y4fRFPVwRWcQvaKCdY4+fEAxOEQWSsS
	VsEeJDU2AQCw3jHefOyI9tih1Z/0PkB+YGoycsn2u6ucNEMMxADWlJVPP+4pq8P6K2pZkCu8LsL
	8jXgwPg9kgtJaRxP4/ar2CVRXO5S1qEhIFkj/Xx3g7tmoZ+YdYtYmH3Vul9So6UG/Y75p4xgkbI
	D92nLU/tV3QVmAniucAmGZc8Nbe1sgb+VxPGEW397HrR2NMJAAiE=
X-Google-Smtp-Source: AGHT+IGuqx/g4fwQyzvi84vhCPzdkjKeAv5E4u9ynj95bID5E3vWrELdmHACBTC2+kl6wOwUYdcL7A==
X-Received: by 2002:a05:600c:870b:b0:440:54ef:dfdc with SMTP id 5b1f17b1804b1-4538ee39982mr46793045e9.8.1751059244604;
        Fri, 27 Jun 2025 14:20:44 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:9b1d:fac1:a77f:a658? ([2001:8b0:aba:5f3c:9b1d:fac1:a77f:a658])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3a5fd2sm61232465e9.15.2025.06.27.14.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 14:20:43 -0700 (PDT)
Message-ID: <95225e9fe50d4f2873b672127a824ff993a2bfeb.camel@linuxfoundation.org>
Subject: Re: [meta-security][PATCH 1/1] Update maintainers
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Scott Murray <scott.murray@konsulko.com>, 
	yocto-patches@lists.yoctoproject.org, Marta Rybczynska
 <rybczynska@gmail.com>
Date: Fri, 27 Jun 2025 22:20:41 +0100
In-Reply-To: <d362cdc5e05123ac1907f64d94ea604fdaab884f.1751049467.git.scott.murray@konsulko.com>
References: <cover.1751049467.git.scott.murray@konsulko.com>
	 <d362cdc5e05123ac1907f64d94ea604fdaab884f.1751049467.git.scott.murray@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 21:20:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1725

T24gRnJpLCAyMDI1LTA2LTI3IGF0IDE0OjQ2IC0wNDAwLCBTY290dCBNdXJyYXkgd3JvdGU6Cj4g
QWRkIE1hcnRhIGFuZCBteXNlbGYgYXMgbWFpbnRhaW5lcnMgZm9yIG1ldGEtc2VjdXJpdHkgYW5k
IHRoZSBvdGhlcgo+IGVtYmVkZGVkIGxheWVycyB0aGF0IEFybWluIGhhZCBiZWVuIG1haW50YWlu
aW5nLsKgIFRvIGF2b2lkIEFybWluCj4gZ2V0dGluZyBidWdnZWQgYWJvdXQgaW5kaXZpZHVhbCBy
ZWNpcGVzLCBzZXQgdGhlIFJFQ0lQRV9NQUlOVEFJTkVSCj4gdmFyaWFibGVzIHRvIG15c2VsZiBm
b3Igbm93IGFzIGEgc3RhcnRpbmcgcG9pbnQgdGhhdCBjYW4gYmUgYWRqdXN0ZWQKPiBhcyB0aGlu
Z3MgZ2V0IG1vcmUgc2V0dGxlZC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBTY290dCBNdXJyYXkgPHNj
b3R0Lm11cnJheUBrb25zdWxrby5jb20+Cj4gLS0tCj4gwqBSRUFETUUubWTCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgIDQgKy0KPiDCoC4uLi9pbmNsdWRlL21haW50YWluZXJzLW1ldGEtc2VjdXJpdHkuaW5j
wqDCoMKgwqAgfCA3MiArKysrKysrKystLS0tLS0tLS0tCj4gwqBtZXRhLWhhcmRlbmluZy9SRUFE
TUUubWTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDQgKy0K
PiDCoG1ldGEtaW50ZWdyaXR5L1JFQURNRS5tZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8wqAgNCArLQo+IMKgbWV0YS10cG0vUkVBRE1FLm1kwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyICsKPiDCoC4u
Li9kaXN0cm8vaW5jbHVkZS9tYWludGFpbmVycy1tZXRhLXRwbS5pbmPCoMKgIHwgMzIgKysrKy0t
LS0tCj4gwqA2IGZpbGVzIGNoYW5nZWQsIDYzIGluc2VydGlvbnMoKyksIDU1IGRlbGV0aW9ucygt
KQoKSSd2ZSBtZXJnZWQgdGhpcyBhbmQgbWFkZSBpdCBvZmZpY2lhbCwgdGhhbmtzIFNjb3R0IGFu
ZCBNYXJ0YS4KCkNoZWVycywKClJpY2hhcmQK


