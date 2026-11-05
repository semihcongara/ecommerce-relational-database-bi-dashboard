ALTER TABLE order_reviews
ADD CONSTRAINT pk_order_reviews
PRIMARY KEY (review_id, order_id);