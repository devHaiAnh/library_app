"""empty message

Revision ID: 07e38a917bbb
Revises: 314d6723e901
Create Date: 2020-06-15 21:01:23.000519

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '07e38a917bbb'
down_revision = '314d6723e901'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('payments',
    sa.Column('paymentId', sa.Integer(), nullable=False),
    sa.Column('image', sa.String(length=255), nullable=True),
    sa.Column('name', sa.String(length=255), nullable=True),
    sa.Column('author', sa.String(length=255), nullable=True),
    sa.Column('evaluateBook', sa.Float(), nullable=True),
    sa.Column('registrationDate', sa.BigInteger(), nullable=True),
    sa.Column('expirationDate', sa.BigInteger(), nullable=True),
    sa.Column('count', sa.Integer(), nullable=True),
    sa.Column('cost', sa.Float(), nullable=True),
    sa.Column('status', sa.Integer(), nullable=True),
    sa.Column('username', sa.String(length=255), nullable=True),
    sa.PrimaryKeyConstraint('paymentId')
    )
    op.add_column('bookmarks', sa.Column('achievements', sa.String(length=255), nullable=True))
    op.add_column('bookmarks', sa.Column('category', sa.String(length=255), nullable=True))
    op.add_column('bookmarks', sa.Column('cost', sa.Float(), nullable=True))
    op.add_column('bookmarks', sa.Column('cover', sa.String(length=255), nullable=True))
    op.add_column('bookmarks', sa.Column('evaluateAuthor', sa.Float(), nullable=True))
    op.add_column('bookmarks', sa.Column('imageAuthor', sa.String(length=255), nullable=True))
    op.add_column('bookmarks', sa.Column('language', sa.String(length=255), nullable=True))
    op.add_column('bookmarks', sa.Column('pages', sa.Integer(), nullable=True))
    op.add_column('bookmarks', sa.Column('writingGenre', sa.String(length=255), nullable=True))
    op.drop_column('bookmarks', 'status')
    op.drop_column('bookmarks', 'registrationDate')
    op.drop_column('bookmarks', 'expirationDate')
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('bookmarks', sa.Column('expirationDate', sa.INTEGER(), autoincrement=False, nullable=True))
    op.add_column('bookmarks', sa.Column('registrationDate', sa.INTEGER(), autoincrement=False, nullable=True))
    op.add_column('bookmarks', sa.Column('status', sa.INTEGER(), autoincrement=False, nullable=True))
    op.drop_column('bookmarks', 'writingGenre')
    op.drop_column('bookmarks', 'pages')
    op.drop_column('bookmarks', 'language')
    op.drop_column('bookmarks', 'imageAuthor')
    op.drop_column('bookmarks', 'evaluateAuthor')
    op.drop_column('bookmarks', 'cover')
    op.drop_column('bookmarks', 'cost')
    op.drop_column('bookmarks', 'category')
    op.drop_column('bookmarks', 'achievements')
    op.drop_table('payments')
    # ### end Alembic commands ###