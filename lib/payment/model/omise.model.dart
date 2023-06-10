// To parse this JSON data, do
//
//     final omiseModel = omiseModelFromJson(jsonString);

import 'dart:convert';

OmiseModel omiseModelFromJson(String str) => OmiseModel.fromJson(json.decode(str));

String omiseModelToJson(OmiseModel data) => json.encode(data.toJson());

class OmiseModel {
    String? object;
    String? id;
    String? location;
    int? amount;
    int? net;
    int? fee;
    int? feeVat;
    int? interest;
    int? interestVat;
    int? fundingAmount;
    int? refundedAmount;
    TransactionFees? transactionFees;
    PlatformFee? platformFee;
    String? currency;
    String? fundingCurrency;
    dynamic ip;
    Refunds? refunds;
    dynamic link;
    String? description;
    // Metadata? metadata;
    Card? card;
    dynamic source;
    dynamic schedule;
    dynamic customer;
    dynamic dispute;
    String? transaction;
    dynamic failureCode;
    dynamic failureMessage;
    String? status;
    dynamic authorizeUri;
    dynamic returnUri;
    DateTime? createdAt;
    DateTime? paidAt;
    DateTime? expiresAt;
    dynamic expiredAt;
    dynamic reversedAt;
    bool? zeroInterestInstallments;
    dynamic branch;
    dynamic terminal;
    dynamic device;
    bool? authorized;
    bool? capturable;
    bool? capture;
    bool? disputable;
    bool? livemode;
    bool? refundable;
    bool? reversed;
    bool? reversible;
    bool? voided;
    bool? paid;
    bool? expired;

    OmiseModel({
        this.object,
        this.id,
        this.location,
        this.amount,
        this.net,
        this.fee,
        this.feeVat,
        this.interest,
        this.interestVat,
        this.fundingAmount,
        this.refundedAmount,
        this.transactionFees,
        this.platformFee,
        this.currency,
        this.fundingCurrency,
        this.ip,
        this.refunds,
        this.link,
        this.description,
        // this.metadata,
        this.card,
        this.source,
        this.schedule,
        this.customer,
        this.dispute,
        this.transaction,
        this.failureCode,
        this.failureMessage,
        this.status,
        this.authorizeUri,
        this.returnUri,
        this.createdAt,
        this.paidAt,
        this.expiresAt,
        this.expiredAt,
        this.reversedAt,
        this.zeroInterestInstallments,
        this.branch,
        this.terminal,
        this.device,
        this.authorized,
        this.capturable,
        this.capture,
        this.disputable,
        this.livemode,
        this.refundable,
        this.reversed,
        this.reversible,
        this.voided,
        this.paid,
        this.expired,
    });

    OmiseModel copyWith({
        String? object,
        String? id,
        String? location,
        int? amount,
        int? net,
        int? fee,
        int? feeVat,
        int? interest,
        int? interestVat,
        int? fundingAmount,
        int? refundedAmount,
        TransactionFees? transactionFees,
        PlatformFee? platformFee,
        String? currency,
        String? fundingCurrency,
        dynamic ip,
        Refunds? refunds,
        dynamic link,
        String? description,
        // Metadata? metadata,
        Card? card,
        dynamic source,
        dynamic schedule,
        dynamic customer,
        dynamic dispute,
        String? transaction,
        dynamic failureCode,
        dynamic failureMessage,
        String? status,
        dynamic authorizeUri,
        dynamic returnUri,
        DateTime? createdAt,
        DateTime? paidAt,
        DateTime? expiresAt,
        dynamic expiredAt,
        dynamic reversedAt,
        bool? zeroInterestInstallments,
        dynamic branch,
        dynamic terminal,
        dynamic device,
        bool? authorized,
        bool? capturable,
        bool? capture,
        bool? disputable,
        bool? livemode,
        bool? refundable,
        bool? reversed,
        bool? reversible,
        bool? voided,
        bool? paid,
        bool? expired,
    }) => 
        OmiseModel(
            object: object ?? this.object,
            id: id ?? this.id,
            location: location ?? this.location,
            amount: amount ?? this.amount,
            net: net ?? this.net,
            fee: fee ?? this.fee,
            feeVat: feeVat ?? this.feeVat,
            interest: interest ?? this.interest,
            interestVat: interestVat ?? this.interestVat,
            fundingAmount: fundingAmount ?? this.fundingAmount,
            refundedAmount: refundedAmount ?? this.refundedAmount,
            transactionFees: transactionFees ?? this.transactionFees,
            platformFee: platformFee ?? this.platformFee,
            currency: currency ?? this.currency,
            fundingCurrency: fundingCurrency ?? this.fundingCurrency,
            ip: ip ?? this.ip,
            refunds: refunds ?? this.refunds,
            link: link ?? this.link,
            description: description ?? this.description,
            // metadata: metadata ?? this.metadata,
            card: card ?? this.card,
            source: source ?? this.source,
            schedule: schedule ?? this.schedule,
            customer: customer ?? this.customer,
            dispute: dispute ?? this.dispute,
            transaction: transaction ?? this.transaction,
            failureCode: failureCode ?? this.failureCode,
            failureMessage: failureMessage ?? this.failureMessage,
            status: status ?? this.status,
            authorizeUri: authorizeUri ?? this.authorizeUri,
            returnUri: returnUri ?? this.returnUri,
            createdAt: createdAt ?? this.createdAt,
            paidAt: paidAt ?? this.paidAt,
            expiresAt: expiresAt ?? this.expiresAt,
            expiredAt: expiredAt ?? this.expiredAt,
            reversedAt: reversedAt ?? this.reversedAt,
            zeroInterestInstallments: zeroInterestInstallments ?? this.zeroInterestInstallments,
            branch: branch ?? this.branch,
            terminal: terminal ?? this.terminal,
            device: device ?? this.device,
            authorized: authorized ?? this.authorized,
            capturable: capturable ?? this.capturable,
            capture: capture ?? this.capture,
            disputable: disputable ?? this.disputable,
            livemode: livemode ?? this.livemode,
            refundable: refundable ?? this.refundable,
            reversed: reversed ?? this.reversed,
            reversible: reversible ?? this.reversible,
            voided: voided ?? this.voided,
            paid: paid ?? this.paid,
            expired: expired ?? this.expired,
        );

    factory OmiseModel.fromJson(Map<String, dynamic> json) => OmiseModel(
        object: json["object"],
        id: json["id"],
        location: json["location"],
        amount: json["amount"],
        net: json["net"],
        fee: json["fee"],
        feeVat: json["fee_vat"],
        interest: json["interest"],
        interestVat: json["interest_vat"],
        fundingAmount: json["funding_amount"],
        refundedAmount: json["refunded_amount"],
        transactionFees: json["transaction_fees"] == null ? null : TransactionFees.fromJson(json["transaction_fees"]),
        platformFee: json["platform_fee"] == null ? null : PlatformFee.fromJson(json["platform_fee"]),
        currency: json["currency"],
        fundingCurrency: json["funding_currency"],
        ip: json["ip"],
        refunds: json["refunds"] == null ? null : Refunds.fromJson(json["refunds"]),
        link: json["link"],
        description: json["description"],
        // metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
        card: json["card"] == null ? null : Card.fromJson(json["card"]),
        source: json["source"],
        schedule: json["schedule"],
        customer: json["customer"],
        dispute: json["dispute"],
        transaction: json["transaction"],
        failureCode: json["failure_code"],
        failureMessage: json["failure_message"],
        status: json["status"],
        authorizeUri: json["authorize_uri"],
        returnUri: json["return_uri"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        paidAt: json["paid_at"] == null ? null : DateTime.parse(json["paid_at"]),
        expiresAt: json["expires_at"] == null ? null : DateTime.parse(json["expires_at"]),
        expiredAt: json["expired_at"],
        reversedAt: json["reversed_at"],
        zeroInterestInstallments: json["zero_interest_installments"],
        branch: json["branch"],
        terminal: json["terminal"],
        device: json["device"],
        authorized: json["authorized"],
        capturable: json["capturable"],
        capture: json["capture"],
        disputable: json["disputable"],
        livemode: json["livemode"],
        refundable: json["refundable"],
        reversed: json["reversed"],
        reversible: json["reversible"],
        voided: json["voided"],
        paid: json["paid"],
        expired: json["expired"],
    );

    Map<String, dynamic> toJson() => {
        "object": object,
        "id": id,
        "location": location,
        "amount": amount,
        "net": net,
        "fee": fee,
        "fee_vat": feeVat,
        "interest": interest,
        "interest_vat": interestVat,
        "funding_amount": fundingAmount,
        "refunded_amount": refundedAmount,
        "transaction_fees": transactionFees?.toJson(),
        "platform_fee": platformFee?.toJson(),
        "currency": currency,
        "funding_currency": fundingCurrency,
        "ip": ip,
        "refunds": refunds?.toJson(),
        "link": link,
        "description": description,
        // "metadata": metadata?.toJson(),
        "card": card?.toJson(),
        "source": source,
        "schedule": schedule,
        "customer": customer,
        "dispute": dispute,
        "transaction": transaction,
        "failure_code": failureCode,
        "failure_message": failureMessage,
        "status": status,
        "authorize_uri": authorizeUri,
        "return_uri": returnUri,
        "created_at": createdAt?.toIso8601String(),
        "paid_at": paidAt?.toIso8601String(),
        "expires_at": expiresAt?.toIso8601String(),
        "expired_at": expiredAt,
        "reversed_at": reversedAt,
        "zero_interest_installments": zeroInterestInstallments,
        "branch": branch,
        "terminal": terminal,
        "device": device,
        "authorized": authorized,
        "capturable": capturable,
        "capture": capture,
        "disputable": disputable,
        "livemode": livemode,
        "refundable": refundable,
        "reversed": reversed,
        "reversible": reversible,
        "voided": voided,
        "paid": paid,
        "expired": expired,
    };
}

class Card {
    String? object;
    String? id;
    bool? livemode;
    dynamic location;
    bool? deleted;
    dynamic street1;
    dynamic street2;
    dynamic city;
    dynamic state;
    dynamic phoneNumber;
    dynamic postalCode;
    String? country;
    String? financing;
    String? bank;
    String? brand;
    String? fingerprint;
    dynamic firstDigits;
    String? lastDigits;
    String? name;
    int? expirationMonth;
    int? expirationYear;
    bool? securityCodeCheck;
    dynamic tokenizationMethod;
    DateTime? createdAt;

    Card({
        this.object,
        this.id,
        this.livemode,
        this.location,
        this.deleted,
        this.street1,
        this.street2,
        this.city,
        this.state,
        this.phoneNumber,
        this.postalCode,
        this.country,
        this.financing,
        this.bank,
        this.brand,
        this.fingerprint,
        this.firstDigits,
        this.lastDigits,
        this.name,
        this.expirationMonth,
        this.expirationYear,
        this.securityCodeCheck,
        this.tokenizationMethod,
        this.createdAt,
    });

    Card copyWith({
        String? object,
        String? id,
        bool? livemode,
        dynamic location,
        bool? deleted,
        dynamic street1,
        dynamic street2,
        dynamic city,
        dynamic state,
        dynamic phoneNumber,
        dynamic postalCode,
        String? country,
        String? financing,
        String? bank,
        String? brand,
        String? fingerprint,
        dynamic firstDigits,
        String? lastDigits,
        String? name,
        int? expirationMonth,
        int? expirationYear,
        bool? securityCodeCheck,
        dynamic tokenizationMethod,
        DateTime? createdAt,
    }) => 
        Card(
            object: object ?? this.object,
            id: id ?? this.id,
            livemode: livemode ?? this.livemode,
            location: location ?? this.location,
            deleted: deleted ?? this.deleted,
            street1: street1 ?? this.street1,
            street2: street2 ?? this.street2,
            city: city ?? this.city,
            state: state ?? this.state,
            phoneNumber: phoneNumber ?? this.phoneNumber,
            postalCode: postalCode ?? this.postalCode,
            country: country ?? this.country,
            financing: financing ?? this.financing,
            bank: bank ?? this.bank,
            brand: brand ?? this.brand,
            fingerprint: fingerprint ?? this.fingerprint,
            firstDigits: firstDigits ?? this.firstDigits,
            lastDigits: lastDigits ?? this.lastDigits,
            name: name ?? this.name,
            expirationMonth: expirationMonth ?? this.expirationMonth,
            expirationYear: expirationYear ?? this.expirationYear,
            securityCodeCheck: securityCodeCheck ?? this.securityCodeCheck,
            tokenizationMethod: tokenizationMethod ?? this.tokenizationMethod,
            createdAt: createdAt ?? this.createdAt,
        );

    factory Card.fromJson(Map<String, dynamic> json) => Card(
        object: json["object"],
        id: json["id"],
        livemode: json["livemode"],
        location: json["location"],
        deleted: json["deleted"],
        street1: json["street1"],
        street2: json["street2"],
        city: json["city"],
        state: json["state"],
        phoneNumber: json["phone_number"],
        postalCode: json["postal_code"],
        country: json["country"],
        financing: json["financing"],
        bank: json["bank"],
        brand: json["brand"],
        fingerprint: json["fingerprint"],
        firstDigits: json["first_digits"],
        lastDigits: json["last_digits"],
        name: json["name"],
        expirationMonth: json["expiration_month"],
        expirationYear: json["expiration_year"],
        securityCodeCheck: json["security_code_check"],
        tokenizationMethod: json["tokenization_method"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "object": object,
        "id": id,
        "livemode": livemode,
        "location": location,
        "deleted": deleted,
        "street1": street1,
        "street2": street2,
        "city": city,
        "state": state,
        "phone_number": phoneNumber,
        "postal_code": postalCode,
        "country": country,
        "financing": financing,
        "bank": bank,
        "brand": brand,
        "fingerprint": fingerprint,
        "first_digits": firstDigits,
        "last_digits": lastDigits,
        "name": name,
        "expiration_month": expirationMonth,
        "expiration_year": expirationYear,
        "security_code_check": securityCodeCheck,
        "tokenization_method": tokenizationMethod,
        "created_at": createdAt?.toIso8601String(),
    };
}

// class Metadata {
//     Metadata();

//     Metadata copyWith({
//     }) => 
//         Metadata(
//         );

//     factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
//     );

//     Map<String, dynamic> toJson() => {
//     };
// }

class PlatformFee {
    dynamic fixed;
    dynamic amount;
    dynamic percentage;

    PlatformFee({
        this.fixed,
        this.amount,
        this.percentage,
    });

    PlatformFee copyWith({
        dynamic fixed,
        dynamic amount,
        dynamic percentage,
    }) => 
        PlatformFee(
            fixed: fixed ?? this.fixed,
            amount: amount ?? this.amount,
            percentage: percentage ?? this.percentage,
        );

    factory PlatformFee.fromJson(Map<String, dynamic> json) => PlatformFee(
        fixed: json["fixed"],
        amount: json["amount"],
        percentage: json["percentage"],
    );

    Map<String, dynamic> toJson() => {
        "fixed": fixed,
        "amount": amount,
        "percentage": percentage,
    };
}

class Refunds {
    String? object;
    List<dynamic>? data;
    int? limit;
    int? offset;
    int? total;
    String? location;
    String? order;
    DateTime? from;
    DateTime? to;

    Refunds({
        this.object,
        this.data,
        this.limit,
        this.offset,
        this.total,
        this.location,
        this.order,
        this.from,
        this.to,
    });

    Refunds copyWith({
        String? object,
        List<dynamic>? data,
        int? limit,
        int? offset,
        int? total,
        String? location,
        String? order,
        DateTime? from,
        DateTime? to,
    }) => 
        Refunds(
            object: object ?? this.object,
            data: data ?? this.data,
            limit: limit ?? this.limit,
            offset: offset ?? this.offset,
            total: total ?? this.total,
            location: location ?? this.location,
            order: order ?? this.order,
            from: from ?? this.from,
            to: to ?? this.to,
        );

    factory Refunds.fromJson(Map<String, dynamic> json) => Refunds(
        object: json["object"],
        data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
        limit: json["limit"],
        offset: json["offset"],
        total: json["total"],
        location: json["location"],
        order: json["order"],
        from: json["from"] == null ? null : DateTime.parse(json["from"]),
        to: json["to"] == null ? null : DateTime.parse(json["to"]),
    );

    Map<String, dynamic> toJson() => {
        "object": object,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
        "limit": limit,
        "offset": offset,
        "total": total,
        "location": location,
        "order": order,
        "from": from?.toIso8601String(),
        "to": to?.toIso8601String(),
    };
}

class TransactionFees {
    String? feeFlat;
    String? feeRate;
    String? vatRate;

    TransactionFees({
        this.feeFlat,
        this.feeRate,
        this.vatRate,
    });

    TransactionFees copyWith({
        String? feeFlat,
        String? feeRate,
        String? vatRate,
    }) => 
        TransactionFees(
            feeFlat: feeFlat ?? this.feeFlat,
            feeRate: feeRate ?? this.feeRate,
            vatRate: vatRate ?? this.vatRate,
        );

    factory TransactionFees.fromJson(Map<String, dynamic> json) => TransactionFees(
        feeFlat: json["fee_flat"],
        feeRate: json["fee_rate"],
        vatRate: json["vat_rate"],
    );

    Map<String, dynamic> toJson() => {
        "fee_flat": feeFlat,
        "fee_rate": feeRate,
        "vat_rate": vatRate,
    };
}
